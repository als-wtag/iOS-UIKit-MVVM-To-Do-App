import UIKit

class TasksTableViewCell: UITableViewCell {
    static let identifier = "CustomContainerCell"
    let customView: TaskCardView = TaskCardView()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCellLayout()
    }

    private func setupCellLayout() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            customView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            customView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            customView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -12
            ),
        ])
    }
}
