//
//  NewToDoViewController.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import UIKit
import SwiftData

class EditToDoViewController: UIViewController {
    var viewModel: EditToDoViewModel
    
    init(viewModel: EditToDoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var toDoTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var todoName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.borderStyle = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)

        textField.layer.cornerRadius = 10
        textField.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        textField.layer.borderWidth = 0.5
        return textField
        
    }()
    
    @objc func valueDidChange(_ sender: UITextField) {
        let isValid = (sender.text ?? "") != viewModel.itemToUpdate?.title
        updateButton.isEnabled = isValid
        updateButton.backgroundColor = isValid ? .systemBlue : .systemGray2
        updateButton.setTitleColor((isValid ? .white : .systemGray), for: .normal)
    }
    
    
    var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "Date and Time"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .automatic
        picker.translatesAutoresizingMaskIntoConstraints = false
//        picker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        picker.contentHorizontalAlignment = .left
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return picker
        
    }()
    @objc func dateChanged(_ sender: UIDatePicker) {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//
//        print("Selected Date: \(formatter.string(from: sender.date))")
    }
    
    @objc func didTapUpdate() {
        viewModel.itemToUpdate?.title = todoName.text!
        viewModel.itemToUpdate?.date = datePicker.date
        viewModel.handleCompletion?(viewModel.itemToUpdate)
        dismiss(animated: true)
    }


    
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)

        
        button.backgroundColor = .systemGray2
        button.setTitleColor(.systemGray, for: .normal)

        button.isEnabled = false
        button.setTitle("Update", for: .normal)
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
                

        navigationItem.title = "Modify Todo"
        view.backgroundColor = .systemBackground
        
        if let itemToUpdate = viewModel.itemToUpdate {
            todoName.text = itemToUpdate.title
            datePicker.date = itemToUpdate.date
        }

        
        view.addSubview(toDoTitle)
        NSLayoutConstraint.activate([
            toDoTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            toDoTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            toDoTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(todoName)
        
        NSLayoutConstraint.activate([
            todoName.topAnchor.constraint(equalTo: toDoTitle.bottomAnchor, constant: 6),
            todoName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            todoName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(dateTitle)
        NSLayoutConstraint.activate([
            dateTitle.topAnchor.constraint(equalTo: todoName.bottomAnchor, constant: 32),
            dateTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            dateTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 6),
            datePicker.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            datePicker.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            updateButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            updateButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    

}
