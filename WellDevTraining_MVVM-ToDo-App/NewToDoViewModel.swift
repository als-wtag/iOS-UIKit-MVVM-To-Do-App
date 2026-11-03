//
//  NewToDoViewModel.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 1/11/26.
//

import Foundation
import SwiftData


class NewToDoViewModel {
    var modelContext: ModelContext?
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func saveToDo(toDo: ToDoItem) -> Bool {
        return saveNewItem(todoItem: toDo)
    }
    
    func saveNewItem(todoItem: ToDoItem) -> Bool {
        modelContext?.insert(todoItem)
        try? modelContext?.save()
        return true
    }
    
    func isValidToDo(toDo: ToDoItem) -> Bool {
        return toDo.title.count > 0
    }
    func isValidToDoTitle(title: String) -> Bool {
        return title.count > 0
    }
}
