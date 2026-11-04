import UIKit

class ProfileTopCardView: UIView {
    private var name: String?
    private let nameLabel: UILabel = UILabel()
    private let subLabel: UILabel = UILabel()
    private let notificationIcon: UIImageView = UIImageView()
    private let menuIcon: UIImageView = UIImageView()
    let addIcon: UIButton = UIButton()

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
    
    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        setupNameLabel()
        setupSubLabel()
        setupMenuIcon()
        setupNotificationIcon()
        setupAddIcon()
    }
    
    private func setupNameLabel() {
        nameLabel.text = "Hello " + (self.name ?? "") + ","
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func setupSubLabel() {
        subLabel.text = "You have work today"
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.textColor = .darkGray
        subLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subLabel.textAlignment = .left
        addSubview(subLabel)
        NSLayoutConstraint.activate([
            subLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            subLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            subLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupNotificationIcon() {
        notificationIcon.image = UIImage(systemName: "bell.badge")
        notificationIcon.translatesAutoresizingMaskIntoConstraints = false
        notificationIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        notificationIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        addSubview(notificationIcon)
        NSLayoutConstraint.activate([
            notificationIcon.rightAnchor.constraint(equalTo: menuIcon.leftAnchor, constant: -10),
            notificationIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }
    
    private func setupMenuIcon() {
        menuIcon.image = UIImage(systemName: "ellipsis")
        menuIcon.translatesAutoresizingMaskIntoConstraints = false
        menuIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        menuIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        addSubview(menuIcon)
        NSLayoutConstraint.activate([
            menuIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            menuIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }
    
    private func setupAddIcon() {
        var config = UIButton.Configuration.plain()
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .default)
        config.image = UIImage(systemName: "plus", withConfiguration: sizeConfig)
        addIcon.configuration = config
        addIcon.translatesAutoresizingMaskIntoConstraints = false
        addIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        addIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        addSubview(addIcon)
        NSLayoutConstraint.activate([
            addIcon.rightAnchor.constraint(equalTo: notificationIcon.leftAnchor, constant: -10),
            addIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
    }
}
