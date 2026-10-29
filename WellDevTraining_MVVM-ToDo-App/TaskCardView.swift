//
//  DashboardCardView.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import UIKit

class TaskCardView: UIView {
    var label: String?
    var date: String?
    var time: String?
    var isDone: Bool?
    
    
    init(label: String? = nil, date: String? = nil, time: String? = nil, isDone: Bool? = nil) {
        self.label = label
        self.date = date
        self.time = time
        self.isDone = isDone
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }


    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.label ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var circleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        return imageView
    }()
    
    lazy var calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = self.date ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var clockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = self.time ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()





    
    private func setupView() {
//        backgroundColor = .red
        
        
//        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(circleIcon)
        
        NSLayoutConstraint.activate([
            circleIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            circleIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        
        
        addSubview(calendarIcon)
        NSLayoutConstraint.activate([
            calendarIcon.leftAnchor.constraint(equalTo: circleIcon.rightAnchor, constant: 20),
            calendarIcon.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
        
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: calendarIcon.rightAnchor, constant: 6),
            dateLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
        
        addSubview(clockIcon)
        NSLayoutConstraint.activate([
            clockIcon.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 20),
            clockIcon.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
        
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: clockIcon.rightAnchor, constant: 6),
            timeLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
        
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: circleIcon.rightAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 2),
//            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        
        
        
        
    }

    func configure(label: String?, date: String?, time: String?, isDone: Bool?) {
        self.label = label
        self.date = date
        self.time = time
        self.isDone = isDone

        titleLabel.text = label ?? ""
        dateLabel.text = date ?? ""
        timeLabel.text = time ?? ""

        // Update the completion icon too.
        circleIcon.image = UIImage(
            systemName: (isDone ?? false) ? "checkmark.circle.fill" : "circle"
        )
    }

}
