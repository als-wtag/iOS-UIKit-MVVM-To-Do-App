import Foundation
import SwiftData

class PersistentDataContext {
    static let shared = PersistentDataContext()
    var modelContext: ModelContext?
    private var sharedModelContainer: ModelContainer?
    
    private init() {
        do {
            sharedModelContainer = try ModelContainer(for: ToDoItem.self)
        } catch {
            print("Failed to initialize SwiftData: \(error)")
        }
        
        guard let container = sharedModelContainer else {
            return
        }
        
        let context = ModelContext(container)
        self.modelContext = context
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
    
    func commitChanges() throws -> () {
        do {
            try modelContext?.save()
        } catch {
            throw error
        }
    }
}
