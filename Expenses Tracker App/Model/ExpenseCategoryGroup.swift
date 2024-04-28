//
//  ExpenseCategoryGroup.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import Foundation
import SwiftData

@Model
final class ExpenseCategoryGroup: Hashable {
    var uuid: UUID
    var name: String
    
    // MARK: - inverse means ForeignKey
    @Relationship(deleteRule: .cascade, inverse: \ExpenseCategoryItem.categoryGroup)
    var items: [ExpenseCategoryItem]? // MARK: - Optional because Category can have 0 item/child
    
    init( name: String) {
        self.uuid = UUID()
        self.name = name
    }
}
