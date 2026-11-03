//
//  ViewController.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import SwiftData
import UIKit
import UserNotifications

class ViewController: UIViewController {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let horizontalStack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()

    let horizontalStack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()

    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()

    let tasksTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    @objc func didTapAdd() {
        let newToDoViewModel = viewModel.makeNewToDoViewModel()
        let newToDoViewController = NewToDoViewController(viewModel: newToDoViewModel)
        newToDoViewController.handleCreateNewToDoCompletion = {
            
            () in self.setupDashboard()
        }
        navigationController?.present(
            UINavigationController(rootViewController: newToDoViewController),
            animated: true
        )
    }

    var todayCard: DashboardCardView = DashboardCardView()
    var scheduledCard: DashboardCardView = DashboardCardView()
    var allCard: DashboardCardView = DashboardCardView()
    var overdueCard: DashboardCardView = DashboardCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
    


        viewModel.tasks = viewModel.toDoTaskModel.getTasks()

        let profileCard = ProfileTopCardView(name: "Minhaj")
        profileCard.addIcon.addTarget(
            self,
            action: #selector(didTapAdd),
            for: .touchUpInside
        )

        view.addSubview(profileCard)
        NSLayoutConstraint.activate([
            profileCard.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: 20
            ),
            profileCard.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: -20
            ),
            profileCard.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 0
            ),
            profileCard.heightAnchor.constraint(equalToConstant: 36),
        ])

        horizontalStack1.addArrangedSubview(todayCard)
        horizontalStack1.addArrangedSubview(scheduledCard)

        horizontalStack2.addArrangedSubview(allCard)
        horizontalStack2.addArrangedSubview(overdueCard)

        verticalStack.addArrangedSubview(horizontalStack1)
        verticalStack.addArrangedSubview(horizontalStack2)

        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(
                equalTo: profileCard.bottomAnchor,
                constant: 30
            ),
            verticalStack.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: 20
            ),
            verticalStack.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: -20
            ),
        ])

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
            tasksTable.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: 12
            ),
            tasksTable.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: -12
            ),
            tasksTable.topAnchor.constraint(
                equalTo: verticalStack.bottomAnchor,
                constant: 20
            ),
            tasksTable.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: 0
            ),
        ])

    }

    func updateDashBoardCounts() {
        let counts = viewModel.groupedTodoCount
        todayCard.countLabel.text = "\(counts.today)"
        scheduledCard.countLabel.text = "\(counts.scheduled)"
        allCard.countLabel.text = "\(counts.all)"
        overdueCard.countLabel.text = "\(counts.overdue)"
    }
    
    @objc func didTapTodayCard(_ sender: UITapGestureRecognizer) {
        let allTasksViewModel = viewModel.makeAllTasksViewModel()
        let allTasksViewController = AllTasksViewController(viewModel: allTasksViewModel)
        navigationController?.pushViewController(allTasksViewController, animated: true)
    }
    
    func setupDashboard() {
        let items = viewModel.fetchItems()
        viewModel.todos = items
        tasksTable.reloadData()

        let counts = viewModel.groupedTodoCount

        todayCard.configure(
            title: "Today",
            count: "\(counts.today)",
            bgColor: Color.lightBlue.rawValue.getColor(),
            iconImage: UIImage(systemName: "clock.fill")
        )

        scheduledCard.configure(
            title: "Scheduled",
            count: "\(counts.scheduled)",
            bgColor: Color.lightYellow.rawValue.getColor(),
            iconImage: UIImage(systemName: "stopwatch.fill")
        )

        allCard.configure(
            title: "All",
            count: "\(counts.all)",
            bgColor: Color.lightGreen.rawValue.getColor(),
            iconImage: UIImage(systemName: "arrow.clockwise.circle.fill")
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTodayCard(_:)))
        allCard.addGestureRecognizer(tapGesture)

        overdueCard.configure(
            title: "Overdue",
            count: "\(counts.overdue    )",
            bgColor: Color.lightPink.rawValue.getColor(),
            iconImage: UIImage(systemName: "gauge.with.needle.fill")
        )

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDashboard()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.todaysTodos.count
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

        let task = viewModel.todaysTodos[indexPath.row]

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
        return "Today's Tasks"
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let editToDoViewModel = viewModel.makeEditToDoViewModel()
        let editToDoViewController = EditToDoViewController(viewModel: editToDoViewModel)
        editToDoViewController.viewModel.itemToUpdate = viewModel.todaysTodos[indexPath.row]
        
        
        var updateIndex = 0
        for i in 0..<viewModel.todos.count {
            if viewModel.todos[i] == viewModel.todaysTodos[indexPath.row] {
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

        navigationController?.present(UINavigationController(rootViewController: editToDoViewController), animated: true)
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

            let item = self.viewModel.todaysTodos[indexPath.row]
            
            var deleteIndex = -1
            for i in 0..<self.viewModel.todos.count {
                if self.viewModel.todos[i] == item {
                    deleteIndex = i
                }
            }
            self.viewModel.todos.remove(at: deleteIndex)

            
            self.viewModel.deleteItem(item: item)
            self.tasksTable.deleteRows(at: [indexPath], with: .fade)
            self.updateDashBoardCounts()

//            // Indicate action completed successfully
            completionHandler(true)
        }
        let isComplete = self.viewModel.todaysTodos[indexPath.row].isCompleted

        let markCompleteAction = UIContextualAction(
            style: .normal,
            title: "Mark As " + (isComplete ? "Inc" : "C") + "omplete"
        ) { (action, view, completionHandler) in
            // Code to execute when swiped
            self.viewModel.todaysTodos[indexPath.row].isCompleted.toggle()
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
