//
//  MealList.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

struct MealList: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
    var id: String { idMeal }
    
    static let example = Meal(idMeal: "52893", strMeal: "Apple & Blackberry Crumble", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!)
}
