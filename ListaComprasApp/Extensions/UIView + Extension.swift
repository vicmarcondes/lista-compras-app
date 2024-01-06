//
//  UIView + Extension.swift
//  ListaComprasApp
//
//  Created by admin on 23/12/23.
//

import Foundation
import UIKit

extension UIView {
    
    func standard() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func borderRounded() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }

}
