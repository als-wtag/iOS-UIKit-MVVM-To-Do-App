//
//  AllTasksViewController.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 2/11/26.
//

import UIKit

class AllTasksViewController: UIViewController {
    let viewModel: AllTasksViewModel
    
    
    init(viewModel: AllTasksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let items = viewModel.fetchItems()
        viewModel.todos = items
        tasksTable.reloadData()
    }
    
    
    
    let tasksTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "All Tasks"

        tasksTable.dataSource = self
        tasksTable.delegate = self
        tasksTable.register(
            TasksTableViewCell.self,
            forCellReuseIdentifier: TasksTableViewCell.identifier
        )
        tasksTable.rowHeight = 72
        tasksTable.estimatedRowHeight = 72

        view.addSubview(tasksTable)
        NSLayoutConstraint.activate([
            tasksTable.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12
            ),
            tasksTable.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12
            ),
            tasksTable.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            tasksTable.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: 0
            ),
        ])
    }


}

extension AllTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TasksTableViewCell.identifier,
                for: indexPath
            ) as? TasksTableViewCell
        else {
            return UITableViewCell()
        }

        let task = viewModel.todos[indexPath.row]

        cell.customView.configure(
            label: task.title,
            date: task.date,
            isCompleted: task.isCompleted
        )

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return "All Tasks"
    }

}


extension AllTasksViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let editToDoViewModel = viewModel.makeEditToDoViewModel()
        let editToDoViewController = EditToDoViewController(viewModel: editToDoViewModel)
        editToDoViewController.viewModel.itemToUpdate = viewModel.todos[indexPath.row]
        
        
        var updateIndex = 0
        for i in 0..<viewModel.todos.count {
            if viewModel.todos[i] == viewModel.todos[indexPath.row] {
                updateIndex = i
            }
        }
        print(updateIndex)
        
        editToDoViewController.viewModel.handleCompletion = {
            (updatedItem: ToDoItem?) in
            if self.viewModel.updateItem(updatedItem: updatedItem, updateIndex: updateIndex) {
                self.tasksTable.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        navigationController?.present(editToDoViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        // Create a contextual action
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            // Code to execute when swiped
            print("Delete tapped for row \(indexPath.row)")

            let item = self.viewModel.todos[indexPath.row]
            
            var deleteIndex = -1
            for i in 0..<self.viewModel.todos.count {
                if self.viewModel.todos[i] == item {
                    deleteIndex = i
                }
            }
            self.viewModel.todos.remove(at: deleteIndex)

            
            self.viewModel.deleteItem(item: item)
            self.tasksTable.deleteRows(at: [indexPath], with: .fade)

//            // Indicate action completed successfully
            completionHandler(true)
        }
        let isComplete = self.viewModel.todos[indexPath.row].isCompleted

        let markCompleteAction = UIContextualAction(
            style: .normal,
            title: "Mark As " + (isComplete ? "Inc" : "C") + "omplete"
        ) { (action, view, completionHandler) in
            // Code to execute when swiped
            self.viewModel.todos[indexPath.row].isCompleted.toggle()
            tableView.reloadRows(at: [indexPath], with: .right)
            tableView.deselectRow(at: indexPath, animated: true)

            // Indicate action completed successfully
            completionHandler(true)
        }

        markCompleteAction.backgroundColor =
            isComplete ? .systemGray : .systemGreen
        markCompleteAction.image = UIImage(
            systemName: "checkmark.square.fill.fill"
        )

        // Return configuration with actions
        let configuration = UISwipeActionsConfiguration(actions: [
            action, markCompleteAction,
        ])
        return configuration
    }

}
