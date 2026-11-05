import Foundation
import SwiftData


// hello world

class AllTasksViewModel {
    private let modelContext: ModelContext? = PersistentDataContext.shared.modelContext
    var todos: [ToDoItem] = []

    func fetchItems() -> [ToDoItem] {
        return PersistentDataContext.shared.fetchItems()
    }
    
    func deleteItem(item: ToDoItem) {
        PersistentDataContext.shared.deleteItem(item: item)
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
}
