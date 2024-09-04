//
//  MealRow.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import SwiftUI

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            AsyncImage(url: meal.strMealThumb) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(meal.strMeal)
                .font(.body)
                .padding(.leading, 10)
        }
    }
}

#Preview {
    MealRow(meal: Meal.example)
}
