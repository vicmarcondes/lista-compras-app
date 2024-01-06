//
//  NewListVC.swift
//  ListaComprasApp
//
//  Created by admin on 24/12/23.
//

import UIKit

class NewListVC: UIViewController {
    private var newListScreen: NewListScreen?
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        newListScreen = NewListScreen()
        view = newListScreen
    }
    
    
}
