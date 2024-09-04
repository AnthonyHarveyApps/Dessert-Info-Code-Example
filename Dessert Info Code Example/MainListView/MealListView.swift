//
//  MealListView.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import SwiftUI
import SwiftData

struct MealListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favs: [FavoritedItem]
    @StateObject var viewModel = MealListViewModel()
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            List {
                if !favs.isEmpty {
                    Section(header: Text(Constants.favorites)) {
                        ForEach(viewModel.meals.filter { meal in
                            favs.contains { $0.id == meal.id }
                        }) { meal in
                            NavigationLink(destination: MealDetailView(mealID: meal.idMeal, strMealThumb: meal.strMealThumb)) {
                                MealRow(meal: meal)
                            }
                        }
                    }
                }
                
                Section(header: Text(searchTerm.isEmpty ? "\(Constants.allMeals)  (Cakes: \(viewModel.cakeCount))" : Constants.searchResults)) {
                    ForEach(viewModel.meals.filter { meal in
                        searchTerm.isEmpty || meal.strMeal.contains(searchTerm)
                    }) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal, strMealThumb: meal.strMealThumb)) {
                            MealRow(meal: meal)
                        }
                    }
                }
            }
            .navigationTitle(Constants.dessertRecipes)
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .task {
                await viewModel.fetchMeals()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text(Constants.error), message: Text(error.message), dismissButton: .default(Text(Constants.ok)) {
                    viewModel.errorMessage = nil
                })
            }
        }
    }
}

#Preview {
    MealListView()
}
