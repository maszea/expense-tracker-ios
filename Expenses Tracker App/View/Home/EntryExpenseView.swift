//
//  EntryExpenseView.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 28/04/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EntryExpenseView: View {
    
    @Query var categoryItems: [ExpenseCategoryItem]
    @Environment(\.modelContext) private var modelContext
    
    @Binding var isPresented: Bool
    @State var expensesTitle: String = ""
    @State var expensesAmount: Int = 0
    @State var expensesDate: Date = Date.now
    
    @State var selectionCategoryId: UUID = UUID()
    
    @State var selectionFlowType: ExpenseFlowType = .expenditure
    
    @State var selectedPhotos: [PhotosPickerItem] = []
    @State var selectedImageData: Data?
    @State var images = [UIImage]()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("e.g: Fly to Jakarta", text: $expensesTitle)
                    
                    TextField("Expenses Ammount", value: $expensesAmount, format: .currency(code: "IDR"))
                    
                    Picker("Category", selection: $selectionCategoryId) {
                        ForEach(categoryItems, id: \.self) { categoryItem in
                            Text(categoryItem.title).tag(categoryItem.uuid)
                        }
                    }
//                    .pickerStyle(.navigationLink)
                    
                    Picker("Flow Type", selection: $selectionFlowType) {
                        ForEach(ExpenseFlowType.allCases, id: \.self) { flowType in
                            Text(flowType.rawValue).tag(flowType)
                        }
                    }
                    
                    DatePicker("Expenses Date", selection: $expensesDate, displayedComponents: .date)
                    
                }
                
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                }
                
                PhotosPicker(selection: $selectedPhotos,
                             maxSelectionCount: 1,
                             selectionBehavior: .ordered,
                             matching: .images
                ) {
                    Label("Selec picture", systemImage: "photo")
                }
                .onChange(of: selectedPhotos) { oldValue, newValue in
                    print("DEBUG: Photo changed!")
                    convertToImages()
                }
            }
            .navigationTitle("Add Expenses")
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
    
    private func convertToImages() {
        
        images.removeAll()
        
        if !selectedPhotos.isEmpty {
            selectedPhotos.forEach { eachPhotoItem in
                Task {
                    if let imageData = try? await eachPhotoItem.loadTransferable(type: Data.self) {
                        self.selectedImageData = imageData // Save for SwiftData database
                        
                        // Save for user
                        if let image = UIImage(data: imageData) {
                            images.append(image)
                        }
                    }
                }
            }
        }
    }
    
    private func save() {
        let expense = Expense(
            title: expensesTitle,
            amount: Double(expensesAmount),
            expenseDate: expensesDate,
            photo: selectedImageData,
            flowType: selectionFlowType
        )
        
        let categoryItem = categoryItems.filter { item in
            item.uuid == selectionCategoryId
        }.first
        
        expense.category = categoryItem
        
        modelContext.insert(expense)
    }
}

#Preview {
    EntryExpenseView(isPresented: .constant(false))
}
