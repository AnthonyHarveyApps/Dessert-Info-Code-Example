//
//  MealListViewModel.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError?
    @Published var cakeCount: Int = 0
    
    /// Cake count feature added so I have something to test
    func updateCakeCount() {
        cakeCount = meals.filter({$0.strMeal.lowercased().contains("cake")}).count
    }
    
    func fetchMeals() async {
        isLoading = true
        errorMessage = nil
        do {
            meals = try await APIService().fetchMeals()
            updateCakeCount()
        } catch {
            errorMessage = IdentifiableError(message: error.localizedDescription) 
        }
    }
}
