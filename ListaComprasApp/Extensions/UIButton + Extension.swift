//
//  Button + Extension.swift
//  ListaComprasApp
//
//  Created by admin on 23/12/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func setButton(title: String, backgroundColor: UIColor, fontColor: UIColor, fontSize: CGFloat) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(fontColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
