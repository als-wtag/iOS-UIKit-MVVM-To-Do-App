import Foundation

struct DashboardCardItems {
    private(set) var label: String
    private(set) var count: String
    private(set) var bgColor: Color
    private(set) var iconImageName: String
    
    init(label: String = "", count: String = "0", bgColor: Color = .lightBlue, iconImageName: String = "") {
        self.label = label
        self.count = count
        self.bgColor = bgColor
        self.iconImageName = iconImageName
    }
}
