//
//  TodoView.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 17/10/2024.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var newItemTitle = ""
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppParameters.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    List {
                        ForEach(viewModel.todoItems) { item in
                            HStack {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                                Text(item.title)
                                    .strikethrough(item.isCompleted)
                                    .foregroundColor(AppParameters.foregroundColor)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .frame(height: 40)
                            .onTapGesture {
                                viewModel.toggleCompletion(for: item)
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                viewModel.deleteItem(viewModel.todoItems[index])
                            }
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                                .padding(.vertical, 4)
                        )
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    
                    HStack {
                        TextField("New item", text: $newItemTitle)
                            .foregroundColor(AppParameters.foregroundColor)
                        Button(action: {
                            if !newItemTitle.isEmpty {
                                viewModel.addItem(newItemTitle)
                                newItemTitle = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.2))
                    )
                    .padding()
                }
                .padding()
            }
            .navigationTitle("To-Do List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TodoView()
}
