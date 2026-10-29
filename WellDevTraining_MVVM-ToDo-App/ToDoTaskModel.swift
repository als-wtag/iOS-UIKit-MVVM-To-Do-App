//
//  ToDoTaskModel.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import Foundation
import UIKit


struct ToDoTask {
    var title: String
    var date: String
    var time: String
    var isDone: Bool
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


