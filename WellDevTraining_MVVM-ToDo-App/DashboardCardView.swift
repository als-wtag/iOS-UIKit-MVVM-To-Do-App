//
//  DashboardCardView.swift
//  WellDevTraining_MVVM-ToDo-App
//
//  Created by Sarowar on 29/10/26.
//

import UIKit

class DashboardCardView: UIView {
    var label: String?
    var count: String?
    var image: String?
    var bgColor: UIColor?
    var iconImage: UIImage?
    
    
    init(label: String? = nil, count: String? = nil, image: String? = nil, bgColor: UIColor? = nil, iconImage: UIImage? = nil) {
        self.label = label
        self.count = count
        self.image = image
        self.bgColor = bgColor
        self.iconImage = iconImage
        super.init(frame: .zero)
        setupView()
    }
    
    lazy var iconCircle: UIView = {
        let circle = UIView()
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 40).isActive = true
        circle.layer.cornerRadius = 20
        circle.backgroundColor = .white
        
        let image = UIImageView()
        image.image = iconImage?.withTintColor(bgColor ?? .systemBlue, renderingMode: .alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        circle.addSubview(image)
        image.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        return circle
    }()


    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.label ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = self.count ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .right
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }


    
    private func setupView() {
        if let bgColor {
            backgroundColor = bgColor
        }
        
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        
        


        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
//            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            countLabel.heightAnchor.constraint(equalToConstant: 30),
//            countLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(iconCircle)
        NSLayoutConstraint.activate([
            iconCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            iconCircle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
        
    }

//    // MARK: - Public API
//    func configure(with title: String) {
//        titleLabel.text = title
//    }

}
