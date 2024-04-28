//
//  Double+Extension.swift
//  Expenses Tracker App
//
//  Created by Alzea Arafat on 28/04/24.
//

import Foundation

extension Double {
    func formattedAsRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
