//
//  UITextField + Extension.swift
//  ListaComprasApp
//
//  Created by admin on 05/01/24.
//

import Foundation
import UIKit

extension UITextField {
    
    func create(text: String, backgroundColor: UIColor, textColor: UIColor) {
        self.standard()
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    func addPlaceholder(placeholderText: String, textColor: UIColor) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: textColor]
        )
    }

    func paddingRight(_ paddingValue: Int) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: 0))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func paddingLeft(_ paddingValue: Int) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
