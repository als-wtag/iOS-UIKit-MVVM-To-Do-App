import Foundation
import SwiftData

class EditToDoViewModel {
    private let modelContext: ModelContext? = PersistentDataContext.shared.modelContext
    var itemToUpdate: ToDoItem?
    var handleCompletion: ((ToDoItem?) -> ())?
    
    func saveToDo(toDo: ToDoItem) -> Bool {
        modelContext?.insert(toDo)
        try? modelContext?.save()
        
        return true
    }
    
    func setItemToUpdate(item: ToDoItem) {
        itemToUpdate = item
    }
    
    func isValidToDo(toDo: ToDoItem) -> Bool {
        return toDo.title.count > 0
    }
    
    func isValidToDoTitle(title: String) -> Bool {
        return title.count > 0
    }
}
