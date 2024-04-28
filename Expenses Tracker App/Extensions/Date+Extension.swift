//
//  Date+Extension.swift
//  Expenses Tracker App
//
//  Created by Alzea Arafat on 28/04/24.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d 'at' h:mma" // formatting here
        return formatter.string(from: self)
    }
}
