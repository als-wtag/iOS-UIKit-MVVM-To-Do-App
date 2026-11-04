import SwiftData
import UIKit

class DashboardViewController: UIViewController {
    private let viewModel: DashboardViewModel = DashboardViewModel()
    private var profileCard: ProfileTopCardView = ProfileTopCardView()
    private var dashboardCardsTopRow: UIStackView = UIStackView()
    private var dashboardCardsBottomRow: UIStackView = UIStackView()
    private let dashboardCardsContainer: UIStackView = UIStackView()
    private let todayCard: DashboardCardView = DashboardCardView()
    private let scheduledCard: DashboardCardView = DashboardCardView()
    private let allCard: DashboardCardView = DashboardCardView()
    private let overdueCard: DashboardCardView = DashboardCardView()
    private let tasksTable: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDashboardCounts()
    }

    private func setupDashboardCardsContainer() {
        dashboardCardsContainer.axis = .vertical
        dashboardCardsContainer.distribution = .fillEqually
        dashboardCardsContainer.alignment = .fill
        dashboardCardsContainer.spacing = 8
    }

    private func setupView() {
        setupProfileCard()
        setupDashboardCards()
        setupToDoTable()
    }

    private func generateDashboardRow() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }

    private func setupProfileCard() {
        profileCard = ProfileTopCardView(name: "Minhaj")
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
    }

    private func setupDashboardCards() {
        dashboardCardsTopRow = generateDashboardRow()
        dashboardCardsBottomRow = generateDashboardRow()
        setupDashboardCardsContainer()
        dashboardCardsTopRow.addArrangedSubview(todayCard)
        dashboardCardsTopRow.addArrangedSubview(scheduledCard)
        dashboardCardsBottomRow.addArrangedSubview(allCard)
        dashboardCardsBottomRow.addArrangedSubview(overdueCard)
        dashboardCardsContainer.addArrangedSubview(dashboardCardsTopRow)
        dashboardCardsContainer.addArrangedSubview(dashboardCardsBottomRow)
        view.addSubview(dashboardCardsContainer)
        dashboardCardsContainer.translatesAutoresizingMaskIntoConstraints =
            false
        NSLayoutConstraint.activate([
            dashboardCardsContainer.topAnchor.constraint(
                equalTo: profileCard.bottomAnchor,
                constant: 30
            ),
            dashboardCardsContainer.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: 20
            ),
            dashboardCardsContainer.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: -20
            ),
        ])
    }

    private func setupToDoTable() {
        tasksTable.translatesAutoresizingMaskIntoConstraints = false
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
                equalTo: dashboardCardsContainer.bottomAnchor,
                constant: 20
            ),
            tasksTable.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: 0
            ),
        ])
    }

    @objc private func didTapAdd() {
        let newToDoViewController = EditToDoViewController(mode: .new)
        newToDoViewController.handleCreateNewToDoCompletion = {
            () in self.setDashboardCounts()
        }
        navigationController?.present(
            UINavigationController(rootViewController: newToDoViewController),
            animated: true
        )
    }

    private func updateDashBoardCounts() {
        let counts = viewModel.groupedTodoCount
        todayCard.countLabel.text = "\(counts.today)"
        scheduledCard.countLabel.text = "\(counts.scheduled)"
        allCard.countLabel.text = "\(counts.all)"
        overdueCard.countLabel.text = "\(counts.overdue)"
    }

    @objc private func didTapTodayCard(_ sender: UITapGestureRecognizer) {
        let allTodosViewController = AllTodosViewController()
        navigationController?.pushViewController(
            allTodosViewController,
            animated: true
        )
    }

    private func setDashboardCounts() {
        let items = viewModel.fetchItems()
        viewModel.todos = items
        tasksTable.reloadData()
        let counts = viewModel.groupedTodoCount

        todayCard.configure(
            cardItems: DashboardCardItems(
                label: "Today",
                count: "\(counts.today)",
                bgColor: .lightBlue,
                iconImageName: "clock.fill"
            )
        )

        scheduledCard.configure(
            cardItems: DashboardCardItems(
                label: "Scheduled",
                count: "\(counts.scheduled)",
                bgColor: .lightYellow,
                iconImageName: "stopwatch.fill"
            )
        )

        allCard.configure(
            cardItems: DashboardCardItems(
                label: "All",
                count: "\(counts.all)",
                bgColor: .lightGreen,
                iconImageName: "arrow.clockwise.circle.fill"
            )
        )
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapTodayCard(_:))
        )
        allCard.addGestureRecognizer(tapGesture)

        overdueCard.configure(
            cardItems: DashboardCardItems(
                label: "Overdue",
                count: "\(counts.overdue)",
                bgColor: .lightPink,
                iconImageName: "gauge.with.needle.fill"
            )
        )
    }
}

extension DashboardViewController: UITableViewDataSource {
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
        return "Today's Tasks"
    }

}

extension DashboardViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let editToDoViewController = EditToDoViewController(mode: .edit)
        editToDoViewController.viewModel.itemToUpdate =
            viewModel.todaysTodos[indexPath.row]

        var updateIndex = 0
        for i in 0..<viewModel.todos.count {
            if viewModel.todos[i] == viewModel.todaysTodos[indexPath.row] {
                updateIndex = i
            }
        }
        
        editToDoViewController.viewModel.handleCompletion = {
            (updatedItem: ToDoItem?) in 
            if self.viewModel.updateItem(
                updatedItem: updatedItem,
                updateIndex: updateIndex
            ) {
                self.tasksTable.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        navigationController?.present(
            UINavigationController(rootViewController: editToDoViewController),
            animated: true
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
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
            completionHandler(true)
        }
        let isComplete = self.viewModel.todaysTodos[indexPath.row].isCompleted
        let markCompleteAction = UIContextualAction(
            style: .normal,
            title: "Mark As " + (isComplete ? "Inc" : "C") + "omplete"
        ) { (action, view, completionHandler) in
            self.viewModel.todaysTodos[indexPath.row].isCompleted.toggle()
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
