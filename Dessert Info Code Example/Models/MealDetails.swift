//
//  MealDetails.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

struct MealDetail: Codable {
    let meals: [MealInfo]
}

struct MealInfo: Codable {
    let strMeal: String
    let strInstructions: String
    let strYoutube: String // None of the YouTube links seem to be working, so not making a player
    var ingredients: [String]
    
    private struct DynamicKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        
        strMeal = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strMeal")!) ?? "Unknown Meal"
        strInstructions = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strInstructions")!) ?? "No instructions available."
        strYoutube = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: "strYoutube")!) ?? ""
        
        var ingredients: [String] = []
        var index = 1
        while true {
            let ingredientKey = DynamicKey(stringValue: "strIngredient\(index)")
            let measureKey = DynamicKey(stringValue: "strMeasure\(index)")
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey!),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey!),
               !ingredient.isEmpty, !measure.isEmpty {
                ingredients.append("\(ingredient) - \(measure)")
            } else {
                break
            }
            index += 1
        }
        self.ingredients = ingredients
    }
}
