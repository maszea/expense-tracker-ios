//
//  CategoryView.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    
//    @Environment(\.modelContext) var modelContext
    @Query var categoryGroups: [ExpenseCategoryGroup]
    
    @State var isAddCategoryPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                List {
                    ForEach(categoryGroups, id: \.self) { category in
                        Section {
                            ForEach(category.items ?? [], id: \.self) { item in
                                NavigationLink {
                                    Text("Tes")
                                } label: {
                                    Label(item.title, systemImage: "person")
                                }
                            }
                        } header: {
                            Text(category.name)
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .sheet(isPresented: $isAddCategoryPresented, content: {
                AddCategoryView(isPresented: $isAddCategoryPresented)
            })
            .toolbar {
                ToolbarItem {
                    Button {
                        isAddCategoryPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    CategoryView()
}
