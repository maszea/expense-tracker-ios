//
//  ExpenseCategoryItem.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import Foundation
import SwiftData

@Model
// MARK: - Hashbale so we can loop this
final class ExpenseCategoryItem: Hashable {
    var uuid: UUID
    var icon: String
    var title: String
    
    // MARK: - Relationship
    var expense: Expense?
    var categoryGroup: ExpenseCategoryGroup?
    
    init(icon: String, title: String) {
        self.uuid = UUID()
        self.icon = icon
        self.title = title
    }
}
