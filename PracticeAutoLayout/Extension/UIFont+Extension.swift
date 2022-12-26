//
//  UIFont+Extension.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//
import UIKit
import Foundation

extension UIFont {
    public enum SunflowerType: String {
        case medium = "-Medium"
        case light = "-Light"
        case bold = "-Bold"
    }

    static func Sunflower(_ type: SunflowerType = .light, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Sunflower\(type.rawValue)", size: size)!
    }
}
