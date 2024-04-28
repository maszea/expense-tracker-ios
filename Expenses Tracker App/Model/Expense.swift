//
//  Expense.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import Foundation
import SwiftData

enum ExpenseFlowType: String, Codable, CaseIterable {
    case income, expenditure
}

@Model
final class Expense: Hashable {
    var title: String
    var amount: Double
    var expenseDate: Date
    var creationDate: Date
    var flowType: ExpenseFlowType
    
    @Attribute(.externalStorage) var photo: Data?
    
    @Relationship(deleteRule: .cascade, inverse: \ExpenseCategoryItem.expense)
    var category: ExpenseCategoryItem?
    
    init(title: String, amount: Double, expenseDate: Date, photo: Data? = nil, flowType: ExpenseFlowType = .expenditure) {
        self.title = title
        self.amount = amount
        self.expenseDate = expenseDate
        self.creationDate = Date.now
        self.photo = photo
        self.flowType = flowType
    }
}
