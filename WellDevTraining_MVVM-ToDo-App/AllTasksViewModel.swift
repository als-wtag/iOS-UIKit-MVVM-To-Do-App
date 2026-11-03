//
//  AllTasksViewModel.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 2/11/26.
//

import Foundation
import SwiftData

class AllTasksViewModel {
    let modelContext: ModelContext?
    
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    var todos: [ToDoItem] = []
    
    
    func fetchItems() -> [ToDoItem] {
        let descriptor = FetchDescriptor<ToDoItem>()
        var items = (try? modelContext?.fetch(descriptor)) ?? []
        items.sort { $0.date < $1.date }
        return items
    }
    
    func deleteItem(item: ToDoItem) {
        modelContext?.delete(item)
        do {
            try modelContext?.save()
        } catch {
            print("Failed to delete item: \(error)")
        }
    }
    func updateItem(updatedItem: ToDoItem?, updateIndex: Int) -> Bool {
        guard let updatedItem else {
            return false
        }
        todos[updateIndex] = updatedItem
        do {
            try modelContext?.save()
        } catch {
            return false
        }
        return true
    }
    
    
    func makeEditToDoViewModel() -> EditToDoViewModel {
        return EditToDoViewModel(modelContext: modelContext)
    }

}
