//
//  DashboardCardView.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import UIKit

class ProfileTopCardView: UIView {

    var name: String?
    
    
    init(name: String? = nil) {
        self.name = name
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


    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello " + (self.name ?? "") + ","
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "You have work today"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var notificationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.badge")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return imageView
    }()
    
    lazy var menuIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "ellipsis")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return imageView
    }()

    private func setupView() {
 
        backgroundColor = .systemBackground
        
//        heightAnchor.constraint(equalToConstant: 100).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),

        ])
        
        addSubview(subLabel)
        NSLayoutConstraint.activate([
            subLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            subLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            subLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
//            subLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        
        
        addSubview(menuIcon)
        NSLayoutConstraint.activate([
//            notificationIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            menuIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            menuIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
//            subLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        addSubview(notificationIcon)
        NSLayoutConstraint.activate([
//            notificationIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            notificationIcon.rightAnchor.constraint(equalTo: menuIcon.leftAnchor, constant: -10),
            notificationIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
//            subLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        

        
    }

//    // MARK: - Public API
//    func configure(with title: String) {
//        titleLabel.text = title
//    }

}
