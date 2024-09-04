//
//  APIService.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

class APIService {
    
    func fetchMeals() async throws -> [Meal] {
        guard let url = URL(string: Constants.fetchingMealsURL) else {
            throw NSError(domain: "", code: -1001, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        let mealList = try JSONDecoder().decode(MealList.self, from: data)
        return mealList.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetails(mealID: String) async throws -> MealInfo {
        guard let url = URL(string: "\(Constants.fetchingDetailsURL)\(mealID)") else {
            throw NSError(domain: "", code: -1001, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        let mealDetail = try JSONDecoder().decode(MealDetail.self, from: data)
        
        guard let details = mealDetail.meals.first else {
            throw NSError(domain: "", code: -1002, userInfo: nil)
        }
        
        return details
    }
}
