//
//  UIColor extension.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 07.04.21.
//

import UIKit

extension UIColor {
    // MARK: HEX
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int & 0xFF, int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(displayP3Red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    convenience init(darkMode: UIColor, lightMode: UIColor) {
        self.init { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkMode : lightMode
        }
    }

    // MARK: Default background
    private class var lightBackground: UIColor {
        return UIColor(hex: "#FFFFFF")
    }

    private class var darkBackground: UIColor {
        return UIColor(hex: "#1C1C1E")
    }

    class var background: UIColor {
        return UIColor(darkMode: darkBackground, lightMode: lightBackground)
    }

    // MARK: Content background
    private class var lightContentBackground: UIColor {
        return UIColor(hex: "#F0F0F0")
    }

    private class var darkContentBackground: UIColor {
        return UIColor(hex: "#212123")
    }

    class var contentBackground: UIColor {
        return UIColor(darkMode: darkContentBackground, lightMode: lightContentBackground)
    }

    // MARK: Text
    private class var lightTextColor: UIColor {
        return UIColor(hex: "#000000")
    }

    private class var darkTextColor: UIColor {
        return UIColor(hex: "#FFFFFF")
    }

    class var text: UIColor {
        return UIColor(darkMode: darkTextColor, lightMode: lightTextColor)
    }
    
    // MARK: Separator
    class var separatorColor: UIColor {
        return UIColor(hex: "#D8D8D8")
    }
    
}
