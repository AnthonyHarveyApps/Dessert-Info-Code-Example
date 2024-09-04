//
//  MealDetailViewModel.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealInfo: MealInfo?
    
    @Published var errorMessage: IdentifiableError?
    
    func fetchMealDetails(mealID: String) async {
        errorMessage = nil
        do {
            mealInfo = try await APIService().fetchMealDetails(mealID: mealID)
        } catch {
            errorMessage = IdentifiableError(message: error.localizedDescription) 
        }
    }
}
