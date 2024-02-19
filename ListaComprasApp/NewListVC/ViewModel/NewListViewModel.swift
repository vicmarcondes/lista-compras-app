//
//  NewListViewModel.swift
//  ListaComprasApp
//
//  Created by admin on 28/01/24.
//

import Foundation
import UIKit

class NewListViewModel {
    private var list: List?
        
    func getProducts() -> [Product] {
        if let products = list?.products as? Set<Product> {
            return Array(products)
        }
        
        return Array()
    }
    
    func getProductsCount() -> Int {
        if let list = self.list {
            return list.products?.count ?? 0
        }
        
        return 0
    }
    
    func loadCurrentProducts(indexPath: IndexPath) -> Product {
        let products = getProducts()
        return products[indexPath.row]
    }
    
    func loadCurrentProducts(index: Int) -> Product {
        let products = getProducts()
        return products[index]
    }
    
    public func addProduct(product: Product) {
        list?.addToProducts(product)
    }
    
    public func editProduct(product: Product, index: Int) {
        var products = getProducts()
        products[index] = product
    }
    
    public func plusProductQuantity(indexPath: IndexPath) {
        let product = loadCurrentProducts(indexPath: indexPath)
        product.quantity += 1
    }
    
    public func subtractProductQuantity(indexPath: IndexPath) {
        let product = loadCurrentProducts(indexPath: indexPath)
        product.quantity -= 1
    }
    
//    public func setProducts(products: [Product]) {
//        
//    }
    
    public func setList(list: List) {
        self.list = list
    }
    
    public func getList() -> List?    {
        return list
    }
    
    
}
