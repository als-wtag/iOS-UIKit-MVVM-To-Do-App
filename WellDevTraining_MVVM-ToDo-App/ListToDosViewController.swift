//
//  ListToDosViewController.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 1/11/26.
//

import UIKit

class ListToDosViewController: UIViewController {
    
    let tasksTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        
        view.addSubview(tasksTable)
        NSLayoutConstraint.activate([
            tasksTable.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: 12
            ),
            tasksTable.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: -12
            ),
            tasksTable.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            tasksTable.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: 20
            ),
        ])
    }

}
