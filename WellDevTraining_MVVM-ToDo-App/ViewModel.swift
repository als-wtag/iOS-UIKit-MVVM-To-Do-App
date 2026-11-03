//
//  ViewModel.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 2/11/26.
//

import Foundation
import SwiftData


class ViewModel {
    var modelContext: ModelContext?
    
    var toDoTaskModel = ToDoTaskModel()
    var tasks: [ToDoTask] = []
    var todos: [ToDoItem] = []
    
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    var groupedTodoCount: GrouppedTodoCount {
        var counts = GrouppedTodoCount(today: 0, scheduled: 0, all: todos.count, overdue: 0)
        for todo in todos {
            if todo.date > Date() {
                counts.scheduled += 1
            }
            if Calendar.current.isDateInToday(todo.date) {
                counts.today += 1
            }
            if todo.date < Date() && !todo.isCompleted {
                counts.overdue += 1
            }
        }
        return counts
    }
    var todaysTodos: [ToDoItem] {
        var filtered = todos.filter { todo in
            return Calendar.current.isDateInToday(todo.date)
        }
        filtered.sort { $0.date < $1.date }
        return filtered
    }
    
    
    
    func fetchItems() -> [ToDoItem] {
        let descriptor = FetchDescriptor<ToDoItem>()
        let items = try? modelContext?.fetch(descriptor)
        return items ?? []
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
    
    func makeNewToDoViewModel() -> NewToDoViewModel {
        return NewToDoViewModel(modelContext: modelContext)
    }
    
    func makeEditToDoViewModel() -> EditToDoViewModel {
        return EditToDoViewModel(modelContext: modelContext)
    }

    func makeAllTasksViewModel() -> AllTasksViewModel {
        return AllTasksViewModel(modelContext: modelContext)
    }
}
