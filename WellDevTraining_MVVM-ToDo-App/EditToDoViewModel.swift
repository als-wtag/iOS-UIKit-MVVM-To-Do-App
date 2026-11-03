//
//  EditToDoViewModel.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 2/11/26.
//

import Foundation
import SwiftData

class EditToDoViewModel {
    let modelContext: ModelContext?
    
    var itemToUpdate: ToDoItem?
    var handleCompletion: ((ToDoItem?) -> ())?
    
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    
    func isValidToDo(toDo: ToDoItem) -> Bool {
        return toDo.title.count > 0
    }
    func isValidToDoTitle(title: String) -> Bool {
        return title.count > 0
    }
}
