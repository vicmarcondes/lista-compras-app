//
//  ViewController.swift
//  ListaComprasApp
//
//  Created by admin on 20/12/23.
//

import UIKit

class HomeVC: UIViewController {
    
    private var homeScreen: HomeScreen?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        homeScreen = HomeScreen()
        homeScreen?.delegate(delegate: self)
        view = homeScreen
    }


}

extension HomeVC: HomeScreenDelegate {
    func tappedGoToLists() {
        do {
            let lists = try context.fetch(List.fetchRequest())
            print("Lists: \(lists[2].name)")
            print("Products: \(lists[2].products?.allObjects.count)")


        } catch {
            print("Error: \(error)")
        }
    }
    
    func tappedGoToNewList() {
        print(#function)
        let newListVC = NewListVC()
        present(newListVC, animated: true)
    }
    
    
}

