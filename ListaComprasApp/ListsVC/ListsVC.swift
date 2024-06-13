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
    var lists = [Lists]()
    private let listsService: ListService = ListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        getAllLists()
//        listsService.createListMock()
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
        
        //add right button
        let createListButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(tappedCreateList))
        navigationItem.rightBarButtonItem = createListButton
    }
    
    @objc private func tappedCreateList() {
        let vc = NewListVC()
        vc.newList = Lists(id: "", name: "Nova Lista", createdAt: Date.now, products: [])
        vc.delegate(delegate: self)
        present(vc, animated: true  )
    }
    
    private func getAllLists() {
//        do {
//            lists = try context.fetch(List.fetchRequest())
//            screen?.tableView.reloadData()
//        } catch {
//            print("Error:  \(error)")
//        }
        
        listsService.getAllLists(completion: { listsData in
            self.lists = listsData
            self.screen?.tableView.reloadData()
        })
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
        vc.delegate(delegate: self)
        vc.setupDataFromListsVC(list: lists[indexPath.row], indexPath: indexPath, service: listsService)
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ListsVC: NewListVCProtocol {
    func updateList() {
        getAllLists()
    }
    
    func deleteList(indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        
        screen?.tableView.reloadData()
    }
    
    func updateList(list: List, indexPath: IndexPath?) {
//        if indexPath != nil {
//            let listToBeUpdated = lists[indexPath!.row]
//            listToBeUpdated.name = list.name
//            listToBeUpdated.products = list.products
//        } else {
//            lists.append(list)
//        }
        
        screen?.tableView.reloadData()
    }
    
}
