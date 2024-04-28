//
//  AddCategoryView.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 28/04/24.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    
    // MARK: - Querying all Category Parent Group, so user can choose from.
    @Query var categoryGroups: [ExpenseCategoryGroup]
    
    @Environment(\.modelContext) var modelContext
    
    @Binding var isPresented: Bool
    @State var categoryTitle: String = ""
    @State var categoryIcon: String = ""
    
    @State var selectionGroupCategoryId: UUID = UUID()
    
    @State var isParentGroup: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("e.g: Netflix", text: $categoryTitle)
                    Toggle("Parent Group", isOn: $isParentGroup)
                    
                    if !isParentGroup {
                        Picker("Tag", selection: $selectionGroupCategoryId) {
                            ForEach(categoryGroups, id: \.self) { group in
                                Text(group.name).tag(group.uuid)
                            }
                            
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
            }
            .navigationTitle("Add Category")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem {
                    Button(action: {
                        save()
                        isPresented = false
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
    
    private func save() {
        if isParentGroup {
            let categoryGroup = ExpenseCategoryGroup(name: categoryTitle)
            
            modelContext.insert(categoryGroup)
        } else {
            let categoryItem = ExpenseCategoryItem(icon: "ellipsis", title: categoryTitle)
            
            let selectedCategoryGroup = categoryGroups.filter { categoryGroup in
                categoryGroup.uuid == selectionGroupCategoryId
            }.first
            
            categoryItem.categoryGroup = selectedCategoryGroup
            
            modelContext.insert(categoryItem)
        }
    }
    
}

#Preview {
    AddCategoryView(isPresented: 
            .constant(false))
            .modelContainer(for: [
                Expense.self,
                ExpenseCategoryGroup.self,
                ExpenseCategoryItem.self
            ], inMemory: true)
}
