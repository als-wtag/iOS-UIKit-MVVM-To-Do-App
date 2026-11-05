import UIKit
import SwiftData

class EditToDoViewController: UIViewController {
    let viewModel: EditToDoViewModel = EditToDoViewModel()
    private let toDoTitle: UILabel = UILabel()
    private let todoName: UITextField = UITextField()
    private let dateTitle: UILabel = UILabel()
    private let datePicker: UIDatePicker = UIDatePicker()
    private let updateButton: UIButton = UIButton()
    var handleCreateNewToDoCompletion: (() -> ())?
    private let mode: AddTodoMode
   
    init(mode: AddTodoMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = mode == .new ? "New Todo" : "Modify Todo"
        view.backgroundColor = .systemBackground
        
        if let itemToUpdate = viewModel.itemToUpdate {
            todoName.text = itemToUpdate.title
            datePicker.date = itemToUpdate.date
        }
        configureViewItems()
        setupSubviews()
    }
    
    private func configureViewItems() {
        disableAutoResizingMask(viewsItems: [toDoTitle, todoName, dateTitle, datePicker, updateButton])
        configureTodoTitle()
        configureTodoName()
        configureDateTitle()
        configureDateTitle()
        configureDatePicker()
        configureUpdateButton()
    }
    
    private func disableAutoResizingMask(viewsItems: [UIView]) {
        for viewsItem in viewsItems {
            viewsItem.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureTodoTitle() {
        toDoTitle.text = "Title"
        toDoTitle.textAlignment = .left
        toDoTitle.font = UIFont.systemFont(ofSize: 20)
        toDoTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        toDoTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTodoName() {
        todoName.translatesAutoresizingMaskIntoConstraints = false
        todoName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        todoName.borderStyle = .none
        todoName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: todoName.frame.height))
        todoName.leftViewMode = .always
        todoName.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        todoName.layer.cornerRadius = 10
        todoName.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        todoName.layer.borderWidth = 0.5
    }
    
    private func configureDateTitle() {
        dateTitle.text = "Date and Time"
        dateTitle.textAlignment = .left
        dateTitle.font = UIFont.systemFont(ofSize: 20)
        dateTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.contentHorizontalAlignment = .left
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    private func configureUpdateButton() {
        updateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        updateButton.backgroundColor = .systemGray2
        updateButton.setTitleColor(.systemGray, for: .normal)
        updateButton.isEnabled = false
        updateButton.setTitle(mode == .new ? "Add To-Do" : "Update", for: .normal)
        updateButton.layer.cornerCurve = .continuous
        updateButton.layer.cornerRadius = 14
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        updateButton.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
    }
    
    private func addSubviewsToHiearrchy(subViews: [UIView]) {
        for subView in subViews {
            view.addSubview(subView)
        }
    }
    
    private func setupSubviews() {
        let subViews: [UIView] = [toDoTitle, todoName, dateTitle, datePicker, updateButton]
        addSubviewsToHiearrchy(subViews: subViews)
        layoutSubviews()
    }
    
    func layoutSubviews() {
        NSLayoutConstraint.activate([
            toDoTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            toDoTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            toDoTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            todoName.topAnchor.constraint(equalTo: toDoTitle.bottomAnchor, constant: 6),
            todoName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            todoName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateTitle.topAnchor.constraint(equalTo: todoName.bottomAnchor, constant: 32),
            dateTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            dateTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 6),
            datePicker.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            datePicker.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            updateButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            updateButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    @objc private func valueDidChange(_ sender: UITextField) {
        let isValid = (sender.text ?? "") != viewModel.itemToUpdate?.title && viewModel.isValidToDoTitle(title: sender.text ?? "")
        updateButton.isEnabled = isValid
        updateButton.backgroundColor = isValid ? .systemBlue : .systemGray2
        updateButton.setTitleColor((isValid ? .white : .systemGray), for: .normal)
    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        
    }
    
    @objc private func didTapUpdate() {
        if mode == .new {
            let newTodo = ToDoItem(title: todoName.text ?? "", date: datePicker.date, isCompleted: false)
            if viewModel.saveToDo(toDo: newTodo)  {
                handleCreateNewToDoCompletion?()
                dismiss(animated: true)
            }
        } else {
            viewModel.itemToUpdate?.title = todoName.text!
            viewModel.itemToUpdate?.date = datePicker.date
            viewModel.handleCompletion?(viewModel.itemToUpdate)
            dismiss(animated: true)
        }
    }
}
