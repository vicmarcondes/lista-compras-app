//
//  NewListVC.swift
//  ListaComprasApp
//
//  Created by admin on 24/12/23.
//
protocol NewListVCProtocol: AnyObject {
    func updateList(list: List, indexPath: IndexPath?)
    func deleteList(indexPath: IndexPath)
}

import UIKit

class NewListVC: UIViewController {
    private var delegate: NewListVCProtocol?
    
    func delegate(delegate: NewListVCProtocol) {
        self.delegate = delegate
    }
    
    private var newListScreen: NewListScreen = NewListScreen()
    private var viewModel: NewListViewModel = NewListViewModel()
    private var alert: Alert?
    private var productIndexPath: IndexPath?
    private var isEditingList: Bool = false
    
    
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
        newListScreen.configTextFieldDelegate(delegate: self)
    }
    
    public func setupDataFromListsVC(list: List, indexPath: IndexPath) {
        viewModel.setList(list: list)
        
        newList = list
        productIndexPath = indexPath
        isEditingList = true
        
        newListScreen.nameTextInput.text = list.name
        newListScreen.deleteButton.isHidden = false
        newListScreen.createListButton.isHidden = true
//        newListScreen.updateListButton.isHidden = false
        
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
        cell?.isEditingList = isEditingList
        cell?.setupCell(product: viewModel.loadCurrentProducts(indexPath: indexPath), indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let produtosSet = newList?.products as? NSMutableSet,
               let produtoParaApagar = produtosSet.allObjects[indexPath.row] as? Product {
                
                produtosSet.remove(produtoParaApagar)
                
                self.context.delete(produtoParaApagar)
                saveContext()
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                self.delegate?.updateList(list: newList!, indexPath: productIndexPath)
            }
        }
    }
}

extension NewListVC: NewListScreenProtocol {
    func tappedUpdateList() {
        guard let list = viewModel.getList() else { return }
        
        list.name = newListScreen.nameTextInput.text
        
//        if let olderProducts = list.products as? Set<Product> {
//            for (index, product) in olderProducts.enumerated() {
//                let updatedProduct = viewModel.loadCurrentProducts(index: index)
//
//                product.name = updatedProduct.name
//                product.quantity = updatedProduct.quantity
//            }
//        }
    }
    
    func tappedDeleteList() {
        guard let list = viewModel.getList() else { return }
        let listName = list.name!

        context.delete(list)
        
        saveContext()
        delegate?.deleteList(indexPath: productIndexPath!   )
        
        alert?.showAlertWithAction(title: "Deletado com sucesso", message: "\(listName) foi deletada com sucesso!", action: { action in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func tappedCreateList() {
        newList = List(context: context)
        newList?.name = newListScreen.nameTextInput.text ?? "Nova lista"
        newList?.createdAt = Date()
        
        for product in viewModel.getProducts() {
            newList?.addToProducts(product)
        }
        
        delegate?.updateList(list: newList!, indexPath: nil)
        saveContext()

        alert?.showAlertWithAction(title: "Lista criada", message: "Sua lista foi criada com sucesso!", action: { alert in
            self.dismiss(animated: true)
        })
    }
    
    func tappedAddProduct(name: String, quantity: String) {
        let product = Product(context: context)
        product.name = name
        product.quantity = Int16(quantity)!
        
        viewModel.addProduct(product: product)
        
        if newList != nil {
            newList?.addToProducts(product)
            saveContext()
        }
        
        newListScreen.quantityTextInput.text = ""
        newListScreen.productTextInput.text = ""
        newListScreen.productTextInput.becomeFirstResponder()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
            return
        }
    }
}

extension NewListVC: ProductsTableViewCellProtocol {
    func tappedProductCheck(product: Product, checked: Bool) {
        for productItem in newList?.products as! Set<Product> {
            if product.id == productItem.id {
                product.checked = checked
            }
        }
        
        saveContext()
        
        delegate?.updateList(list: newList!, indexPath: self.productIndexPath!)
    }
    
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

extension NewListVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if newList != nil && !text.isEmpty && isEditingList {
            newList?.name = text
            
            saveContext()
            delegate?.updateList(list: newList!, indexPath: productIndexPath!)
        }
    }
}
