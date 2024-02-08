//
//  Product+CoreDataProperties.swift
//  ListaComprasApp
//
//  Created by admin on 07/02/24.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var list: List?

}

extension Product : Identifiable {

}
