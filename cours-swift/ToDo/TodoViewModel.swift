//
//  TodoViewModel.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 17/10/2024.
//
import Foundation

class TodoViewModel: ObservableObject {
    @Published var todoItems: [Task] = []
    
    func addItem(_ title: String) {
        let newItem = Task(title: title)
        todoItems.append(newItem)
    }
    
    func toggleCompletion(for item: Task) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }
    
    func deleteItem(_ item: Task) {
        todoItems.removeAll { $0.id == item.id }
    }
}
