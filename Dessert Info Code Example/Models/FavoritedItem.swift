//
//  FavoritedItem.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation
import SwiftData

@Model
final class FavoritedItem {
    var timestamp: Date
    var id: String
    
    init(timestamp: Date, id: String) {
        self.timestamp = timestamp
        self.id = id
    }
}
