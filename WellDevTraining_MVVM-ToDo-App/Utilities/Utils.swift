import Foundation
import UIKit

//func convertFromHex(hex: String) {
//    UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
//}

struct ColorComponents: Equatable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    func getColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

enum Color: RawRepresentable {
    typealias RawValue = ColorComponents
    case lightYellow, lightPink, lightBlue, lightGreen

    var rawValue: ColorComponents {
        switch self {
        case .lightBlue: return ColorComponents(red: 180 / 255.0, green: 196 / 255.0, blue: 255 / 255.0, alpha: 1)
        case .lightYellow: return ColorComponents(red: 255 / 255.0, green: 245 / 255.0, blue: 127 / 255.0, alpha: 1)
        case .lightGreen: return ColorComponents(red: 207 / 255.0, green: 243 / 255.0, blue: 233 / 255.0, alpha: 1)
        case .lightPink: return ColorComponents(red: 255 / 255.0, green: 192 / 255.0, blue: 245 / 255.0, alpha: 1)
        }
    }
    
    init?(rawValue: ColorComponents) {
        switch rawValue {
        case ColorComponents(red: 180 / 255.0, green: 196 / 255.0, blue: 255 / 255.0, alpha: 1): self = .lightBlue
        case ColorComponents(red: 255 / 255.0, green: 245 / 255.0, blue: 127 / 255.0, alpha: 1): self = .lightYellow
        case ColorComponents(red: 207 / 255.0, green: 243 / 255.0, blue: 233 / 255.0, alpha: 1): self = .lightGreen
        case ColorComponents(red: 255 / 255.0, green: 192 / 255.0, blue: 245 / 255.0, alpha: 1): self = .lightPink
        default: return nil
        }
    }
}

enum AddTodoMode {
    case new
    case edit
}
