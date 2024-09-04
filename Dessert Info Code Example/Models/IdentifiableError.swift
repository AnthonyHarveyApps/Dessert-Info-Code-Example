//
//  IdentifiableError.swift
//  Dessert Info Code Example
//
//  Created by Anthony Harvey on 9/3/24.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id: UUID
    let message: String

    init(message: String) {
        self.id = UUID()
        self.message = message
    }
}
