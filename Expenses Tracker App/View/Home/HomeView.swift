//
//  HomeView.swift
//  Expenses Tracker App
//
//  Created by Rizal Hilman on 27/04/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Query(sort: \Expense.creationDate, order: .reverse) var expenses: [Expense]
    
    @State var isAddNewPresented = false
    
    @State var currentBalance: Double = 0.0
    @State var totalExpenses: Double = 0.0
    @State var totalIncome: Double = 0.0
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { geometry in
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(.blue)
                        .frame(height: geometry.size.height * 0.5)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("Current Balance")
                        Text("Rp21.000.000")
                            .font(.system(size: 50))
                        Text("April 2024")
                            .font(.subheadline)
                            .lineSpacing(10)
                        
                        HStack {
                            VStack {
                                Label("Income", systemImage: "arrow.down")
                                    .fontWeight(.light)
                                Text("Rp3.000.000")
                                    .font(.headline)
                            }
                            Spacer()
                            VStack {
                                Label("Expenses", systemImage: "arrow.up")
                                Text("Rp1.000.000")
                                    .font(.headline)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    List {
                        ForEach(expenses, id: \.self) { expense in
                            VStack {
                                HStack {
                                    Image(systemName: expense.flowType == .income ? "dollarsign" : "cart.badge.minus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(expense.flowType == .income ? .yellow : .red)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading) {
                                        Text(expense.title)
                                        Text("\(expense.expenseDate.formattedString())")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer()
                                    Text("\(expense.flowType == .income ? "+" : "-")\(expense.amount.formattedAsRupiah())")
                                        .fontWeight(.medium)
                                        .font(.subheadline)
                                        .foregroundStyle(expense.flowType == .income ? .green : .black)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.74)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .listStyle(.plain)
                    .toolbar {
                        ToolbarItem {
                            Button {
                                isAddNewPresented = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                                    .padding(8)
                                    .background(.yellow)
                                    .clipShape(Circle())
                            }
                            
                        }
                    }
                    .offset(y: 180)
                }
            })
            .sheet(isPresented: $isAddNewPresented, onDismiss: {
                
            }, content: {
                EntryExpenseView(isPresented: $isAddNewPresented)
            })
            .onAppear(perform: {
                
            })
        }
    }
}

#Preview {
    HomeView()
}
