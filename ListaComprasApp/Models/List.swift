//
//  Product.swift
//  ListaComprasApp
//
//  Created by admin on 24/05/24.
//

import Foundation
import FirebaseFirestore


struct Lists {
    var id: String;
    var name: String;
    var createdAt: Date;
    var products: [Products]
    
    init(id: String, name: String, createdAt: Date, products: [Products]) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.products = products
    }
    
    init(list: [String: Any]) {
        self.id = list["id"] as! String
        self.name = list["name"] as! String
        
        let stamp = list["createdAt"] as? Timestamp
        let date = stamp!.dateValue()
        self.createdAt = date
        
        self.products = list["products"] as! [Products]
    }
    
    func toDictionary() -> [String: Any]{
        var products = [[String: Any]]()
        
        for product in self.products {
            var productDictionary = [String: Any]()
            
            productDictionary["checked"] = product.checked
            productDictionary["name"] = product.name
            productDictionary["quantity"] = product.quantity
            productDictionary["id"] = product.id
            
            products.append(productDictionary)
        }
        
        return [
            "name": self.name,
            "createdAt": self.createdAt,
            "products": products
        ]
    }
}

struct Products {
    var id: String;
    var name: String;
    var checked: Bool;
    var quantity: Int;
    
    static func toDictionnary(products: [Products]) -> [[String: Any]] {
        var productsDictionary = [[String: Any]]()
        
        for product in products {
            var productDicionaty = [String: Any]()
            
            productDicionaty["name"] = product.name
            productDicionaty["id"] = product.id
            productDicionaty["checked"] = product.checked
            productDicionaty["quantity"] = product.quantity
            
            productsDictionary.append(productDicionaty)
        }
        
        return productsDictionary
    }
    
    static func toDictionnary(product: Products) -> [String: Any] {
        var productDicionaty = [String: Any]()
        
        productDicionaty["name"] = product.name
        productDicionaty["id"] = product.id
        productDicionaty["checked"] = product.checked
        productDicionaty["quantity"] = product.quantity
        
        return productDicionaty
    }
}
