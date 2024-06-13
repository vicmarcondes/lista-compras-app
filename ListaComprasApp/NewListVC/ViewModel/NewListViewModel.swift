//
//  NewListViewModel.swift
//  ListaComprasApp
//
//  Created by admin on 28/01/24.
//

import Foundation
import UIKit

class NewListViewModel {
    private var list: Lists?
    
    private var products: [Products] = []
    
    func getProducts() -> [Products] {
        return list?.products ?? []
    }
    
    func loadCurrentProducts(indexPath: IndexPath) -> Products {
        return list?.products[indexPath.row] ?? Products(id: "teste", name: "teste", checked: false, quantity: 4)
    }
    
    func loadCurrentProducts(index: Int) -> Products {
        return list?.products[index] ?? Products(id: "teste", name: "teste", checked: false, quantity: 4)
    }
    
    func addProduct(product: Products) {
        list?.products.append(product)
    }
    
    public func plusProductQuantity(indexPath: IndexPath) {
        list?.products[indexPath.row].quantity += 1
    }
    
    public func subtractProductQuantity(indexPath: IndexPath) {
        list?.products[indexPath.row].quantity -= 1
    }
    
    public func setProducts(products: [Products]) {
        self.products = products
    }
    
    public func setList(list: Lists) {
        self.list = list
    }
    
    public func getList() -> Lists?    {
        return list
    }
}
