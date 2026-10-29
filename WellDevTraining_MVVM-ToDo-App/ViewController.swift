//
//  ViewController.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import UIKit

class ViewController: UIViewController {
    var todayCard: DashboardCardView = DashboardCardView(
        label: "Today",
        count: "12",
        bgColor: UIColor.red
    )
    var scheduledCard: DashboardCardView = DashboardCardView(
        label: "Scheduled",
        count: "13",
        bgColor: UIColor.green
    )
    var allCard: DashboardCardView = DashboardCardView(
        label: "All",
        count: "13",
        bgColor: UIColor.green
    )
    var overdueCard: DashboardCardView = DashboardCardView(
        label: "Overdue",
        count: "13",
        bgColor: UIColor.green
    )

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
    
    
    
    var toDoTaskModel = ToDoTaskModel()
    var tasks: [ToDoTask] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
   
        tasks = toDoTaskModel.getTasks()

        let profileCard = ProfileTopCardView(name: "Minhaj")
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

        let view1 = DashboardCardView(
            label: "Today",
            count: "13",
            bgColor: UIColor(red: 180/255.0, green: 196/255.0, blue: 255/255.0, alpha: 1)
        )
        let view2 = DashboardCardView(
            label: "Scheduled",
            count: "13",
            bgColor: UIColor(red: 255/255.0, green: 245/255.0, blue: 127/255.0, alpha: 1)
        )
        let view3 = DashboardCardView(
            label: "All",
            count: "13",
            bgColor: UIColor(red: 207/255.0, green: 243/255.0, blue: 233/255.0, alpha: 1)
        )
        let view4 = DashboardCardView(
            label: "Overdue",
            count: "13",
            bgColor: UIColor(red: 255/255.0, green: 192/255.0, blue: 245/255.0, alpha: 1)
        )

        horizontalStack1.addArrangedSubview(view1)
        horizontalStack1.addArrangedSubview(view2)

        horizontalStack2.addArrangedSubview(view3)
        horizontalStack2.addArrangedSubview(view4)

        verticalStack.addArrangedSubview(horizontalStack1)
        verticalStack.addArrangedSubview(horizontalStack2)

        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(
                equalTo: profileCard.bottomAnchor,
                constant: 20
            ),
            verticalStack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            verticalStack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
        ])

        
        
        tasksTable.dataSource = self
        tasksTable.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.identifier)
        tasksTable.rowHeight = 72
        tasksTable.estimatedRowHeight = 72
        
        view.addSubview(tasksTable)
        NSLayoutConstraint.activate([
            tasksTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tasksTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            tasksTable.topAnchor.constraint(
                equalTo: verticalStack.bottomAnchor,
                constant: 20
            ),
            tasksTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        

    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return tasks.count    }

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
        
        
        let task = tasks[indexPath.row]

        cell.customView.configure(
            label: task.title,
            date: task.date,
            time: task.time,
            isDone: task.isDone
        )

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todays Task"
    }
    
    

}
