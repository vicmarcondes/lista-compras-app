//
//  NewListViewModel.swift
//  ListaComprasApp
//
//  Created by admin on 28/01/24.
//

import Foundation
import UIKit

class NewListViewModel {
    
    private var products: [Product] = []
    
    func getProducts() -> [Product] {
        return products
    }
    
    func loadCurrentProducts(indexPath: IndexPath) -> Product {
        return products[indexPath.row]
    }
    
    public func addProduct(product: Product) {
        products.append(product)
    }
    
    public func plusProductQuantity(indexPath: IndexPath) {
        products[indexPath.row].quantity += 1
    }
    
    public func subtractProductQuantity(indexPath: IndexPath) {
        products[indexPath.row].quantity -= 1
    }
    
    public func setProducts(products: [Product]) {
        self.products = products
    }
}
