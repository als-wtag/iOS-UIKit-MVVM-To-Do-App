import UIKit

class TaskCardView: UIView {
    private let todoTask: ToDoItem = ToDoItem()
    private let titleLabel: UILabel = UILabel()
    private let circleIcon: UIImageView = UIImageView()
    private let calendarIcon: UIImageView = UIImageView()
    private let dateLabel: UILabel = UILabel()
    private let clockIcon: UIImageView = UIImageView()
    private let timeLabel: UILabel = UILabel()
    
    init() {
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
        translatesAutoresizingMaskIntoConstraints = false
        setupToDoRow()
    }
    
    private func setupToDoRow() {
        let subViews: [UIView] = [circleIcon, calendarIcon, dateLabel, clockIcon, timeLabel, titleLabel]
        addSubViewsToHiearrchy(subViews: subViews)
        setupTitleLabel()
        setupCicleIcon()
        setupCalendarIcon()
        setupDateLabel()
        setupClockIcon()
        setupTimeLabel()
    }
    
    private func addSubViewsToHiearrchy(subViews: [UIView]) {
        for subView in subViews {
            addSubview(subView)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.text = self.todoTask.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textAlignment = .left
        layoutTitleLabel()
    }
    
    private func setupCicleIcon() {
        circleIcon.image = UIImage(systemName: "circle")
        circleIcon.translatesAutoresizingMaskIntoConstraints = false
        circleIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        circleIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        layoutCircleIcon()
    }
    
    private func setupCalendarIcon() {
        calendarIcon.image = UIImage(systemName: "calendar")
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        calendarIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        calendarIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        layoutCalendarIcon()
    }
    
    private func setupDateLabel() {
        let date = self.todoTask.date.formatted(date: .abbreviated, time: .omitted)
        dateLabel.text = Calendar.current.isDateInToday(self.todoTask.date) ? "Today" : date
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .label
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textAlignment = .left
        layoutDateLabel()
    }
    
    private func setupClockIcon() {
        clockIcon.image = UIImage(systemName: "clock")
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        clockIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        clockIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        layoutClockIcon()
    }
    
    private func setupTimeLabel() {
        let time = self.todoTask.date.formatted(date: .omitted, time: .shortened)
        timeLabel.text = time
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = .label
        timeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        timeLabel.textAlignment = .left
        layoutTimeLabel()
    }

    private func layoutCircleIcon() {
        NSLayoutConstraint.activate([
            circleIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            circleIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func layoutCalendarIcon() {
        NSLayoutConstraint.activate([
            calendarIcon.leftAnchor.constraint(equalTo: circleIcon.rightAnchor, constant: 20),
            calendarIcon.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
    }
    
    private func layoutDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: calendarIcon.rightAnchor, constant: 6),
            dateLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
    }
    
    private func layoutClockIcon() {
        NSLayoutConstraint.activate([
            clockIcon.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 20),
            clockIcon.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
    }
    
    private func layoutTimeLabel() {
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: clockIcon.rightAnchor, constant: 6),
            timeLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),
        ])
    }
    
    private func layoutTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: circleIcon.rightAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 2),
        ])
    }
   
    func configure(title: String, date: Date, isCompleted: Bool) {
        self.todoTask.title = title
        self.todoTask.date = date
        self.todoTask.isCompleted = isCompleted
        titleLabel.text = title
        let dateStr = date.formatted(date: .abbreviated, time: .omitted)
        let timeStr = date.formatted(date: .omitted, time: .shortened)
        dateLabel.text = Calendar.current.isDateInToday(self.todoTask.date) ? "Today" : dateStr
        timeLabel.text = timeStr
        circleIcon.image = UIImage(
            systemName: isCompleted ? "checkmark.circle.fill" : "circle"
        )
    }
}
