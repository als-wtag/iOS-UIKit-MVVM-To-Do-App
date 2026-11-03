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
    var bgColor: UIColor?
    var iconImage: UIImage?

    init(
        label: String? = nil,
        count: String? = nil,
        bgColor: UIColor? = nil,
        iconImage: UIImage? = nil
    ) {
        self.label = label
        self.count = count
        self.bgColor = bgColor
        self.iconImage = iconImage
        super.init(frame: .zero)
        setupView()
    }

    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = iconImage
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    lazy var iconCircle: UIView = {
        let circle = UIView()

        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 40).isActive = true
        circle.layer.cornerRadius = 20
        circle.backgroundColor = .white

        //        let image = UIImageView()
        //        image.image = iconImage?.withTintColor(bgColor ?? .systemBlue, renderingMode: .alwaysOriginal)
        //        image.translatesAutoresizingMaskIntoConstraints = false
        //
        circle.addSubview(iconImageView)
        iconImageView.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
            .isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
            .isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive =
            true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive =
            true

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
        isUserInteractionEnabled = true
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -10
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            //            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])

        addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.rightAnchor.constraint(
                equalTo: rightAnchor,
                constant: -10
            ),
            countLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -10
            ),
            countLabel.heightAnchor.constraint(equalToConstant: 30),
            //            countLabel.widthAnchor.constraint(equalToConstant: 100)
        ])

        addSubview(iconCircle)
        NSLayoutConstraint.activate([
            iconCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            iconCircle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])

    }

    // MARK: - Public API
    func configure(
        title: String,
        count: String,
        bgColor: UIColor,
        iconImage: UIImage?
    ) {
        titleLabel.text = title
        countLabel.text = count

        backgroundColor = bgColor
   
        iconImageView.image = iconImage?.withTintColor(
            bgColor, renderingMode: .alwaysOriginal
        )

    }

}
