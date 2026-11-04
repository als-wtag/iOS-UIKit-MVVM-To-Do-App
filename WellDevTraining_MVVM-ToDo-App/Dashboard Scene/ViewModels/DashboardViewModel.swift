import Foundation
import SwiftData

class DashboardViewModel {
    private var modelContext: ModelContext? = PersistentDataContext.shared.modelContext
    var todos: [ToDoItem] = []
    
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
            try PersistentDataContext.shared.commitChanges()
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
            try PersistentDataContext.shared.commitChanges()
        } catch {
            print("Failed to update item: \(error)")
            return false
        }
        return true
    }
}
