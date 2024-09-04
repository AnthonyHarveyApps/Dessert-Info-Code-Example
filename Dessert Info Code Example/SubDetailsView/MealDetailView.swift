//
//  MealDetailView.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import SwiftUI
import SwiftData

struct MealDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favs: [FavoritedItem]
    @StateObject private var viewModel = MealDetailViewModel()
    
    let mealID: String
    let strMealThumb: URL

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
 
                if let mealInfo = viewModel.mealInfo {
                    Text(mealInfo.strMeal)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    mealImage
                    
                    Text(Constants.instructions)
                        .font(.headline)
                    
                    Text(mealInfo.strInstructions)
                        .font(.body)
                    
                    Text(Constants.ingredients)
                        .font(.headline)
                    
                    ForEach(mealInfo.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.body)
                    }
                } else {
                    Text(Constants.mealInfoNotAvailable)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    favoriteButton
                }
            }
            .task {
                await viewModel.fetchMealDetails(mealID: mealID)
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text(Constants.error), message: Text(error.message), dismissButton: .default(Text(Constants.ok)) {
                    viewModel.errorMessage = nil
                })
            }
        }
    }
    
    // MARK: - VIEWS:
    private var mealImage: some View {
        AsyncImage(url: strMealThumb) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .aspectRatio(contentMode: .fit)
    }
    
    private var favoriteButton: some View {
        if favs.contains(where: {$0.id == mealID}) {
            Button(action: {
                unFavorite()
            }) {
                Image(systemName: Constants.favoritedSymbolName)
                    .foregroundColor(.red)
            }
        } else {
            Button(action: {
                favorite()
            }) {
                Image(systemName: Constants.notFavoritedSymbolName)
                    .foregroundColor(.gray)
            }
        }
    }
    
    // MARK: - METHODS:
    private func favorite() {
        withAnimation {
            let newFav = FavoritedItem(timestamp: Date(), id: mealID)
            modelContext.insert(newFav)
        }
    }
    
    private func unFavorite() {
        withAnimation {
            if let fav = favs.first(where: {$0.id == mealID}) {
                modelContext.delete(fav)
            }
        }
    }
}

#Preview {
    MealDetailView(mealID: Meal.example.id, strMealThumb: Meal.example.strMealThumb)
}
