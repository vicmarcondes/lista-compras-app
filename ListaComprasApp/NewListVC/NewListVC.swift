//
//  NewListVC.swift
//  ListaComprasApp
//
//  Created by admin on 24/12/23.
//

import UIKit

class NewListVC: UIViewController {
    private var newListScreen: NewListScreen = NewListScreen()
    private var viewModel: NewListViewModel = NewListViewModel()
    private var alert: Alert?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var newList: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        
        alert = Alert(controller: self)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        
        view = newListScreen
        newListScreen.configTableViewDelegateAndDatasource(delegate: self, datasource: self)
        newListScreen.delegate(delegate: self)
        newListScreen.configAlertController(controller: self)
        
        newList = List(context: context)
    }
    
    public func setupData(list: List) {
        newListScreen.nameTextInput.text = list.name
        
        if let products = list.products as? Set<Product> {
            viewModel.setProducts(products: Array(products))
            newListScreen.productsTableView.reloadData()
        }
    }
    
    
}

extension NewListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell
        cell?.contentView.isUserInteractionEnabled = false
        cell?.delegate(delegate: self)
        cell?.setupCell(product: viewModel.loadCurrentProducts(indexPath: indexPath), indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension NewListVC: NewListScreenProtocol {
    func tappedCreateList() {
        newList?.name = newListScreen.nameTextInput.text ?? "Nova lista"
        
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
            return
        }
        
        alert?.showAlertWithAction(title: "Lista criada", message: "Sua lista foi criada com sucesso!", action: { alert in
            self.dismiss(animated: true)
        })
    }
    
    func tappedAddProduct(name: String, quantity: String) {
        let product = Product(context: context)
        product.name = name
        product.quantity = Int16(quantity)!
        
        newList?.addToProducts(product)
        viewModel.addProduct(product: product)
    }
}

extension NewListVC: ProductsTableViewCellProtocol {
    func tappedPlusQuantityButton(indexPath: IndexPath) {
        viewModel.plusProductQuantity(indexPath: indexPath)
        newListScreen.productsTableView.reloadData()
    }
    
    func tappedMinusQuantityButton(indexPath: IndexPath) {
        viewModel.subtractProductQuantity(indexPath: indexPath)
        newListScreen.productsTableView.reloadData()
//        let product = viewModel.loadCurrentProducts(indexPath: indexPath)
    }
}
