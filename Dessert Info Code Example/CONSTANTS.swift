//
//  CONSTANTS.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

enum Constants {
    static let fetchingMealsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let fetchingDetailsURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    static let favorites = "Favorites"
    static let allMeals = "All Meals"
    static let searchResults = "Search Results"
    static let dessertRecipes = "Dessert Recipes"
    static let instructions = "Instructions"
    static let ingredients = "Ingredients"
    static let favoritedSymbolName = "heart.fill"
    static let notFavoritedSymbolName = "heart"
    static let mealInfoNotAvailable = "Meal Info Not Available"
    static let error = "Error"
    static let ok = "OK"
}
