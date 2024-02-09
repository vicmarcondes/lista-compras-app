//
//  ListsVC.swift
//  ListaComprasApp
//
//  Created by admin on 08/02/24.
//

import UIKit

class ListsVC: UIViewController {

    private var screen: ListsScreen?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        getAllLists()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        screen = ListsScreen()
        screen?.configDelegateAndDatasource(delegate: self, detasource: self)
        view = screen
    }

    private func configureNavigationBar() {
        // change title
        navigationItem.title = "Listas"

        // change title color
        let textChangeColor = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = textChangeColor
        navigationController?.navigationBar.largeTitleTextAttributes = textChangeColor
        
        view.backgroundColor = .appBlue
    }
    
    private func getAllLists() {
        do {
            lists = try context.fetch(List.fetchRequest())
            screen?.tableView.reloadData()
        } catch {
            print("Error:  \(error)")
        }
    }
}

extension ListsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListsTableViewCell.identifier, for: indexPath) as? ListsTableViewCell
        cell?.setupCell(list: lists[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewListVC()
        vc.setupData(list: lists[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
