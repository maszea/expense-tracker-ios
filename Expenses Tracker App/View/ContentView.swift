//
//  ContentView.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
         
            ChartView()
                .tabItem {
                    Label("Chart", systemImage: "chart.bar")
                }
            CategoryView()
                .tabItem {
                    Label("Category", systemImage: "rectangle.3.group")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
