import UIKit

class AllTodosViewController: UIViewController {
    private let viewModel: AllTasksViewModel = AllTasksViewModel()
    private let todosTable: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "All Tasks"
        setupTodosTable()
        
        let items = viewModel.fetchItems()
        viewModel.todos = items
        todosTable.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        
//    }
    
    private func setupTodosTable() {
        todosTable.dataSource = self
        todosTable.delegate = self
        todosTable.register(
            TasksTableViewCell.self,
            forCellReuseIdentifier: TasksTableViewCell.identifier
        )
        todosTable.rowHeight = 72
        todosTable.estimatedRowHeight = 72
        todosTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todosTable)
        NSLayoutConstraint.activate([
            todosTable.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12
            ),
            todosTable.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12
            ),
            todosTable.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            todosTable.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: 0
            ),
        ])
    }
}

extension AllTodosViewController: UITableViewDataSource {
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
            title: task.title,
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


extension AllTodosViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let editToDoViewController = EditToDoViewController(mode: .edit)
        editToDoViewController.viewModel.itemToUpdate = viewModel.todos[indexPath.row]
        var updateIndex = 0
        
        for i in 0..<viewModel.todos.count {
            if viewModel.todos[i] == viewModel.todos[indexPath.row] {
                updateIndex = i
            }
        }
        
        editToDoViewController.viewModel.handleCompletion = {
            (updatedItem: ToDoItem?) in
            if self.viewModel.updateItem(updatedItem: updatedItem, updateIndex: updateIndex) {
                self.todosTable.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        navigationController?.present(editToDoViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let item = self.viewModel.todos[indexPath.row]
            
            var deleteIndex = -1
            for i in 0..<self.viewModel.todos.count {
                if self.viewModel.todos[i] == item {
                    deleteIndex = i
                }
            }
            
            self.viewModel.todos.remove(at: deleteIndex)
            self.viewModel.deleteItem(item: item)
            self.todosTable.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let isComplete = self.viewModel.todos[indexPath.row].isCompleted
        let markCompleteAction = UIContextualAction(
            style: .normal,
            title: "Mark As " + (isComplete ? "Inc" : "C") + "omplete"
        ) { (action, view, completionHandler) in
            self.viewModel.todos[indexPath.row].isCompleted.toggle()
            tableView.reloadRows(at: [indexPath], with: .right)
            tableView.deselectRow(at: indexPath, animated: true)
            completionHandler(true)
        }

        markCompleteAction.backgroundColor =
            isComplete ? .systemGray : .systemGreen
        markCompleteAction.image = UIImage(
            systemName: "checkmark.square.fill.fill"
        )
        
        let configuration = UISwipeActionsConfiguration(actions: [
            action, markCompleteAction,
        ])
        return configuration
    }
}
