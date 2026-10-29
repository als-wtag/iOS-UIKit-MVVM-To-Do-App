//
//  NewToDoViewController.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import UIKit

class NewToDoViewController: UIViewController {
    
    lazy var todoName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.borderStyle = .line
        textField.layer.borderWidth = 4
        return textField
        
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .automatic
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        picker.contentHorizontalAlignment = .center
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
    
    @objc func lol() {
        print(datePicker.date)
        navigationController?.popViewController(animated: true)
    }
    
    
    lazy var addButton: UIButton = {
        var config = UIButton.Configuration.filled()

        config.baseForegroundColor = .white

        config.background.backgroundColor = .systemBlue

        let button = UIButton(type: .system)
        button.configuration = config
        
        button.setTitle("Add", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(lol), for: .touchUpInside)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Todo"
        view.backgroundColor = .yellow
        
        
        view.addSubview(todoName)
        
        NSLayoutConstraint.activate([
            todoName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            todoName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            todoName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: todoName.bottomAnchor, constant: 40),
            datePicker.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            datePicker.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 100),
            addButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    

}
