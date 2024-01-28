//
//  NewListVC.swift
//  ListaComprasApp
//
//  Created by admin on 24/12/23.
//

import UIKit

class NewListVC: UIViewController {
    private var newListScreen: NewListScreen?
    private var viewModel: NewListViewModel = NewListViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        newListScreen = NewListScreen()
        view = newListScreen
        newListScreen?.configTableViewDelegateAndDatasource(delegate: self, datasource: self)
        newListScreen?.delegate(delegate: self)
    }
    
    
    
    
}

extension NewListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell
        cell?.setupCell(product: viewModel.loadCurrentProducts(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
}

extension NewListVC: NewListScreenProtocol {
    func tappedAddProduct(product: Product) {
        viewModel.addProduct(product: product)
    }
    
    
}
