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
    
    
    init(label: String? = nil, count: String? = nil, image: String? = nil, bgColor: UIColor? = nil) {
        self.label = label
        self.count = count
        self.image = image
        self.bgColor = bgColor
        super.init(frame: .zero)
        setupView()
    }


    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.label ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = self.count ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .semibold)
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
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            countLabel.heightAnchor.constraint(equalToConstant: 30),
            countLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }

//    // MARK: - Public API
//    func configure(with title: String) {
//        titleLabel.text = title
//    }

}
