//
//  Expenses_Tracker_AppApp.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import SwiftUI
import SwiftData

@main
struct Expenses_Tracker_AppApp: App {
    
    // MARK: - Computer Properties/Var
    var sharedModelContainer: ModelContainer = {
        let scheme = Schema([
            Expense.self,
            ExpenseCategoryGroup.self,
            ExpenseCategoryItem.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: scheme, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: scheme, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create data \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}
