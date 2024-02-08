//
//  Alert.swift
//  ListaComprasApp
//
//  Created by admin on 06/02/24.
//

import Foundation
import UIKit

class Alert {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        controller.present(alert, animated: true)
    }
    
    public func showAlertWithAction(title: String, message: String, action: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: action)
        alert.addAction(ok)
        controller.present(alert, animated: true)
    }
    
}
