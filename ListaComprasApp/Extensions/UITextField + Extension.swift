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
    
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
//        self.textContainerInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
}
