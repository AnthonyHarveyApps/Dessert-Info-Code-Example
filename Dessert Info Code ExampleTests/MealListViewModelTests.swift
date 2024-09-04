//
//  Dessert_Info_Code_ExampleTests.swift
//  Dessert Info Code ExampleTests
//
//  Created by Anthony Harvey on 9/3/24.
//

import XCTest
@testable import Dessert_Info_Code_Example

final class MealListViewModelTests: XCTestCase {
    var viewModel: MealListViewModel!
    let url = URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = MealListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor func testUpdateCakeCountWithNoMeals() {
        viewModel.meals = []
        viewModel.updateCakeCount()
        XCTAssertEqual(viewModel.cakeCount, 0, "Cake count should be 0 when no meals are present")
    }
    
    @MainActor func testUpdateCakeCountWithNoCakes() {
        viewModel.meals = [
            Meal(idMeal: "1", strMeal: "Apple Pie", strMealThumb: url),
            Meal(idMeal: "2", strMeal: "Fried Rice", strMealThumb: url)
        ]
        viewModel.updateCakeCount()
        XCTAssertEqual(viewModel.cakeCount, 0, "Cake count should be 0 when no meal names contain 'cake'")
    }
    
    @MainActor func testUpdateCakeCountCaseSensitivity() {
        viewModel.meals = [
            Meal(idMeal: "1", strMeal: "chocolate cake", strMealThumb: url),
            Meal(idMeal: "2", strMeal: "Cheese CAKE", strMealThumb: url)
        ]
        viewModel.updateCakeCount()
        XCTAssertEqual(viewModel.cakeCount, 2, "Cake count should include meals with 'cake' in any case")
    }
    
    @MainActor func testUpdateCakeCountWithSubstrings() {
        viewModel.meals = [
            Meal(idMeal: "1", strMeal: "Pancake", strMealThumb: url),
            Meal(idMeal: "2", strMeal: "Cheesecake", strMealThumb: url)
        ]
        viewModel.updateCakeCount()
        XCTAssertEqual(viewModel.cakeCount, 2, "Cake count should include meals with substrings like 'pancake' and 'cheesecake'")
    }
    
    @MainActor func testUpdateCakeCountWithSpecialCharacters() {
        viewModel.meals = [
            Meal(idMeal: "1", strMeal: "Cupcake@", strMealThumb: url),
            Meal(idMeal: "2", strMeal: "Fruit Cake #1", strMealThumb: url)
        ]
        viewModel.updateCakeCount()
        XCTAssertEqual(viewModel.cakeCount, 2, "Cake count should handle meal names with special characters correctly")
    }
    
    @MainActor func testUpdateCakeCountWithLargeMealNames() {
        viewModel.meals = [
            Meal(idMeal: "1", strMeal: String(repeating: "Sponge Cake ", count: 1000), strMealThumb: url)
        ]
        viewModel.updateCakeCount()
        XCTAssertEqual(viewModel.cakeCount, 1, "Cake count should handle very large meal names without performance issues")
    }
}
