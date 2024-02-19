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
import CoreData

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
    private var isInitialSetup: Bool = true
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var newList: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        
        alert = Alert(controller: self)
//        viewModel.setList(list: List(context: context))
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
        
        productIndexPath = indexPath
        isEditingList = true
        
        newListScreen.nameTextInput.text = list.name
        newListScreen.deleteButton.isHidden = false
        newListScreen.createListButton.isHidden = true
//        newListScreen.updateListButton.isHidden = false
        newListScreen.productsTableView.reloadData()
        
//        if let products = list.products as? Set<Product> {
//            viewModel.setProducts(products: Array(products))
//        }
    }

}

extension NewListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell
        let product = viewModel.loadCurrentProducts(indexPath: indexPath)
        
        cell?.contentView.isUserInteractionEnabled = false
        cell?.delegate(delegate: self)
        cell?.setupCell(product: product, indexPath: indexPath)
        cell?.checkboxProduct.isHidden = !isEditingList
        
        return cell ?? UITableViewCell()
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
        delegate?.deleteList(indexPath: productIndexPath!)
        
        alert?.showAlertWithAction(title: "Deletado com sucesso", message: "\(listName) foi deletada com sucesso!", action: { action in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func tappedCreateList() {
        let newList = viewModel.getList()!
        newList.name = newListScreen.nameTextInput.text ?? "Nova lista"
        newList.createdAt = Date()
        
        for product in viewModel.getProducts() {
            newList.addToProducts(product)
        }
        
        viewModel.setList(list: newList)
        
        delegate?.updateList(list: newList, indexPath: nil)
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
        newListScreen.productsTableView.reloadData()
        
        if isEditingList  {
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
    func tappedCheck(productIndexPath: IndexPath, isChecked: Bool) {
        let product = viewModel.loadCurrentProducts(indexPath: productIndexPath)
        product.checked = isChecked
            
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", product.name!)
        
        do {
            let productContext = try context.fetch(fetchRequest)
            let productFirst = productContext.first
            productFirst?.checked = isChecked
            
            saveContext()
        } catch {
            print("Error: \(error)")
        }
        
        let list = viewModel.getList()
        let products = list?.products
        if let productsSet = products as? Set<Product> {
            let productsArray = Array(productsSet)
            productsArray[productIndexPath.row].checked = isChecked
            viewModel.setList(list: list!)
            delegate?.updateList(list: list!, indexPath: self.productIndexPath!)
        }
        
        
    }
    
    func tappedCheckOff(indexPath: IndexPath) {
        
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
        let list = viewModel.getList()
        guard let text = textField.text else { return }
        
        if list != nil && !text.isEmpty && isEditingList {
            list?.name = text
            
            saveContext()
            delegate?.updateList(list: list!, indexPath: productIndexPath!)
        }
    }
}
