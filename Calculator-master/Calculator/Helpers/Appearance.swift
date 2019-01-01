//
//  Appearance.swift
//  Calculator
//


import UIKit.UIColor

enum Appearance {
    case white, blue, bg, red
    
    var color: UIColor {
        switch self {
        case .white: return UIColor(hexString: "#F4F5F9")
        case .blue: return UIColor(hexString: "#927F8A")
        case .bg: return UIColor(hexString: "#35394C")
        case .red: return UIColor(hexString: "#EA3E49")
        }
    }
    
    static var michiganBlue = #colorLiteral(red: 0, green: 0.1519076228, blue: 0.2992945313, alpha: 1)
    static var michiganMaize = #colorLiteral(red: 0.9965139031, green: 0.792604506, blue: 0.02251920663, alpha: 1)
    static var michiganTan = #colorLiteral(red: 0.8103260398, green: 0.7535114884, blue: 0.5882748365, alpha: 1)
    static var michiganBeige = #colorLiteral(red: 0.6063866615, green: 0.6027674675, blue: 0.4269524217, alpha: 1)
    static var michiganGray = #colorLiteral(red: 0.5955243707, green: 0.6100042462, blue: 0.5919004083, alpha: 1)
    static var michiganAsh = #colorLiteral(red: 0.6532951593, green: 0.6172346473, blue: 0.5882748365, alpha: 1)
    static var michiganOrange = #colorLiteral(red: 0.8103260398, green: 0.7535114884, blue: 0.5882748365, alpha: 1)
    static var michiganCoolBlue = #colorLiteral(red: 0.3447138667, green: 0.4786932468, blue: 0.7356921434, alpha: 1)
    static var michiganImage = UIImage(named: "MichiganLogo")
    static var salmonColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    

static func customAppearance(){
    
    UINavigationBar.appearance().barTintColor = michiganCoolBlue
    UINavigationBar.appearance().backgroundColor = michiganCoolBlue
    
    
    
    
    UIBarButtonItem.appearance().tintColor = michiganMaize
    
    let attributes = [NSAttributedString.Key.foregroundColor : michiganMaize]
    UINavigationBar.appearance().titleTextAttributes = attributes
    UINavigationBar.appearance().largeTitleTextAttributes = attributes
    
    UITableViewCell.appearance().backgroundColor = michiganAsh
    UITableView.appearance().backgroundColor = michiganAsh
    UITableView.appearance().sectionIndexColor = michiganTan
    
    // UITableViewCell.appearance().tintColor =
    
    UITextField.appearance().keyboardAppearance = .dark
    
    //UILabel = michiganMaize
    
}
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
