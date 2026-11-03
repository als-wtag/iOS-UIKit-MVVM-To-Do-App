//
//  ToDoTaskModel.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import Foundation
import UIKit
import SwiftData


struct ToDoTask {
    var title: String
    var date: String
    var time: String
    var isDone: Bool
}

struct GrouppedTodoCount {
    var today: Int
    var scheduled: Int
    var all: Int
    var overdue: Int
}

class ToDoTaskModel {
    let tasks: [ToDoTask] = [
        ToDoTask(title: "Project retrospective", date: "Today", time: "12:35 PM", isDone: false),
        ToDoTask(title: "Evening team meeting", date: "Today", time: "5:00 PM", isDone: false),
        ToDoTask(title: "Create monthly deck", date: "Today", time: "6:30 PM", isDone: false),
        ToDoTask(title: "Shop for groceries", date: "Today", time: "7:00 PM", isDone: false)
    ]
    
    func getTasks() -> [ToDoTask] {
        return tasks
    }
}
@Model
class ToDoItem {
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(title: String, date: Date, isCompleted: Bool) {
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}


