import UIKit

class DashboardCardView: UIView {
    private let cardItems: DashboardCardItems = DashboardCardItems()
    private let iconImageView: UIImageView = UIImageView()
    private let iconCircle: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    let countLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    init() {
        super.init(frame: .zero)
        setupView()
    }

    private func setupView() {
        isUserInteractionEnabled = true
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        setupIconImageView()
        setupIconCircle()
        setupTitleLabel()
        setupCountLabel()
    }
    
    private func setupIconImageView() {
        iconImageView.image = UIImage(systemName: cardItems.iconImageName)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupIconCircle() {
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        iconCircle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        iconCircle.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconCircle.layer.cornerRadius = 20
        iconCircle.backgroundColor = .white
        iconCircle.addSubview(iconImageView)
        iconImageView.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor)
            .isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor)
            .isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive =
            true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive =
            true
        
        addSubview(iconCircle)
        NSLayoutConstraint.activate([
            iconCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            iconCircle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = self.cardItems.label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -10
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setupCountLabel() {
        countLabel.text = self.cardItems.count
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.textColor = .label
        countLabel.font = .systemFont(ofSize: 30, weight: .regular)
        countLabel.textAlignment = .right
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
        ])
    }

    func configure(cardItems: DashboardCardItems) {
        titleLabel.text = cardItems.label
        countLabel.text = cardItems.count
        backgroundColor = cardItems.bgColor.rawValue.getColor()
        iconImageView.image = UIImage(systemName: cardItems.iconImageName)?.withTintColor(
            cardItems.bgColor.rawValue.getColor(), renderingMode: .alwaysOriginal
        )
    }
}
