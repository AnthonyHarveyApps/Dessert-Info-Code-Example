//
//  MealListViewModelPerformanceTests.swift
//  Dessert Info Code ExampleTests
//
//  Created by Anthony Harvey on 9/3/24.
//

import XCTest
@testable import Dessert_Info_Code_Example

class MealListViewModelPerformanceTests: XCTestCase {
    var viewModel: MealListViewModel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = MealListViewModel()
        viewModel.meals = (1...1000).map { i in
            Meal(idMeal: "\(i)", strMeal: i % 2 == 0 ? "Cake \(i)" : "Meal \(i)", strMealThumb: URL(string: "https://example.com/meal\(i).jpg")!)
        }
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testPerformanceUpdateCakeCount() {
        self.measure {
            let expectation = XCTestExpectation(description: "Update cake count on main actor")
            
            Task {
                await MainActor.run {
                    self.viewModel.updateCakeCount()
                    expectation.fulfill()
                }
            }

            wait(for: [expectation], timeout: 10.0)
        }
    }
}
