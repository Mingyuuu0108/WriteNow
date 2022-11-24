//
//  File.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/20.
//

import UIKit

public extension UIColor {
    
    class var mainColor: UIColor? { return UIColor(named: "mainColor") }
}

public extension UITextField {
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
}
