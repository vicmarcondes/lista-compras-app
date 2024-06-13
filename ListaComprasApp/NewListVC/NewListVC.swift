//
//  NewListVC.swift
//  ListaComprasApp
//
//  Created by admin on 24/12/23.
//
import UIKit

protocol NewListVCProtocol: AnyObject {
    func updateList()
    func deleteList(indexPath: IndexPath)
}

class NewListVC: UIViewController {
    var listsService: ListService = ListService()
    
    private var delegate: NewListVCProtocol?
    
    func delegate(delegate: NewListVCProtocol) {
        self.delegate = delegate
    }
    
    private var newListScreen: NewListScreen = NewListScreen()
//    private var viewModel: NewListViewModel = NewListViewModel()
    private var alert: Alert?
    private var productIndexPath: IndexPath?
    private var isEditingList: Bool = false


    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var newList: Lists?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlue
        
        alert = Alert(controller: self)
        
        listsService.addProduct(listId: "Nf4oJOFS72SftheZehU2", product: Products(id: "", name: "tainha", checked: false, quantity: 2)) { success in
            print(success)
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = newListScreen
        newListScreen.configTableViewDelegateAndDatasource(delegate: self, datasource: self)
        newListScreen.delegate(delegate: self)
        newListScreen.configAlertController(controller: self)
        newListScreen.configTextFieldDelegate(delegate: self)
    }
    
    public func setupDataFromListsVC(list: Lists, indexPath: IndexPath, service: ListService) {
        newList = list
        productIndexPath = indexPath
        isEditingList = true
        
//        listsService = service
        
        newListScreen.nameTextInput.text = list.name
        newListScreen.deleteButton.isHidden = false
        newListScreen.createListButton.isHidden = true
//        newListScreen.updateListButton.isHidden = false
//        newListScreen.productsTableView.reloadData()
        
        listsService.updateCheckedProduct(listId: "Nf4oJOFS72SftheZehU2", productId: "id2", checked: false) { success in
            print(success)
        }
    }

}

extension NewListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newList?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell
        cell?.contentView.isUserInteractionEnabled = false
        cell?.delegate(delegate: self)
        cell?.isEditingList = isEditingList
        guard let product = newList?.products[indexPath.row]  else {return UITableViewCell()}
        cell?.setupCell(product: product, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        delete method
        
        if (editingStyle == .delete) {
            if let productToDelete = newList?.products[indexPath.row] {
                listsService.deleteProduct(listId: newList!.id, productId: productToDelete.id) { list in
                    if list != nil {
                        self.newList = list
                        tableView.deleteRows(at: [indexPath], with: .fade)

                    }
                }
            }
        }
    }
}

extension NewListVC: NewListScreenProtocol {
    func tappedUpdateList() {
//        guard let list = viewModel.getList() else { return }
        
        // update method (deprecated)
//        list.name = newListScreen.nameTextInput.text
        
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
        guard let list = newList else { return }
        
//        delegate?.deleteList(indexPath: productIndexPath!   )

        listsService.deleteList(id: list.id) { success in
            if success {
                self.alert?.showAlertWithAction(title: "Deletado com sucesso", message: "\(list.name) foi deletada com sucesso!", action: { action in
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    func tappedCreateList() {
        
        let listName = newListScreen.nameTextInput.text ?? "Nova lista"
        let createdAt = Date()
        
        let list = Lists(id: "", name: listName, createdAt: createdAt, products: newList?.products ?? [])
        
        listsService.createList(list: list) { success in
            if success {
                self.delegate?.updateList()
                self.alert?.showAlertWithAction(title: "Lista criada", message: "Sua lista foi criada com sucesso!", action: { alert in
                    self.dismiss(animated: true)
                })

            }
        }

    }
    
    func tappedAddProduct(name: String, quantity: String) {
        listsService.addProduct(listId: "Nf4oJOFS72SftheZehU2", product: Products(id: "", name: "amora", checked: false, quantity: 2)) { success in

        }
        
//        let id = UUID().uuidString
//        let quantityInt = Int(quantity) ?? 0
//        let product = Products(id: id, name: name, checked: false, quantity: quantityInt)
//        
//        newList?.products.append(product)
//        newListScreen.productsTableView.reloadData()
//        
//        if isEditingList {
//            guard let list = newList else { return }
//            
//            listService.addProduct(listId: list.id, product: product) { succcess in
//                
//            }
//        }
//        
//        newListScreen.quantityTextInput.text = ""
//        newListScreen.productTextInput.text = ""
//        newListScreen.productTextInput.becomeFirstResponder()
    }
}

extension NewListVC: ProductsTableViewCellProtocol {
    func tappedProductCheck(product: Products, checked: Bool) {
        guard let list = newList else { return }
        
        listsService.updateCheckedProduct(listId: list.id, productId: product.id, checked: checked) { success in
            print("DEU BOM")
        }
    }
    
    func tappedPlusQuantityButton(indexPath: IndexPath) {
//        viewModel.plusProductQuantity(indexPath: indexPath)
        newList?.products[indexPath.row].quantity -= 1
        newListScreen.productsTableView.reloadData()
    }
    
    func tappedMinusQuantityButton(indexPath: IndexPath) {
        newList?.products[indexPath.row].quantity += 1
        newListScreen.productsTableView.reloadData()
//        let product = viewModel.loadCurrentProducts(indexPath: indexPath)
    }
}

extension NewListVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//        
//        if newList != nil && !text.isEmpty && isEditingList {
//            newList?.name = text
//            
//            saveContext()
//            delegate?.updateList(list: newList!, indexPath: productIndexPath!)
//        }
    }
}
