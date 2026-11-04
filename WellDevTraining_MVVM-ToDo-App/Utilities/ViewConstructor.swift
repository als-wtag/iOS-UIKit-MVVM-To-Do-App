import UIKit

struct UILabelConfig {
    var text: String
    var textAlignment: NSTextAlignment
    var font: UIFont
}

class ViewConstructor {
    static func getUILabel(config: UILabelConfig) -> UILabel {
        let label = UILabel()
        label.text = config.text
        label.textAlignment = config.textAlignment
        label.font = config.font
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
}
