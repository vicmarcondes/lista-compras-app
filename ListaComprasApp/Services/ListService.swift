//
//  ListService.swift
//  ListaComprasApp
//
//  Created by admin on 24/05/24.
//

import Foundation
import FirebaseFirestore

class ListService {
    let db = Firestore.firestore()
    
    func createList(list: Lists, completion: @escaping (Bool) -> Void) {
        
        // Cria um novo documento na coleção "listas"
        let listaRef = db.collection("lists").document()
        
        let listDic = list.toDictionary()
        
        listaRef.setData([
            "name": listDic["name"]!,
            "createdAt": Date.now,
            "products": listDic["products"]!
            
        ]) { err in
            if let err = err {
                print("Erro ao salvar a lista: \(err)")
                completion(false)
            } else {
                print("Lista salva com sucesso")
                completion(true)
            }
        }
    }
    
    func createListMock() {
        
        // Cria um novo documento na coleção "listas"
        let listaRef = db.collection("lists").document()
        
        let product1: [String:Any] = [
            "id": "id1",
            "name":  "Banana",
            "checked": true,
            "quantity": 4
        ]
        
        let product2: [String:Any] = [
            "id": "id2",
            "name":  "Pera",
            "checked": false,
            "quantity": 8
        ]
        
        let products = [product1, product2]
        
        listaRef.setData([
            "name": "listMock",
            "createdAt": Date.now,
            "products": products
            
        ]) { err in
            if let err = err {
                print("Erro ao salvar a lista: \(err)")
            } else {
                print("Lista salva com sucesso")
            }
        }
    }
    
    func deleteProduct(listId: String, productId: String, completion: @escaping (Lists?) -> Void) {
        let listRef = db.collection("lists").document(listId)
        
        listRef.getDocument { document, error in
            if let document = document, document.exists {
                let listData = document.data()
                var products = listData?["products"] as? [[String: Any]] ?? []
                
                products.removeAll { product in
                    return product["id"] as? String  == productId
                }
                
                listRef.updateData(["products": products]) { err in
                    if err != nil {
//                        print(err?.localizedDescription)
                        completion(nil)
                    } else {
                        let list = Lists(list: listData!)
                        completion(list)
                    }
                }
                
            }
        }
    }
    
    func getAllLists(completion: @escaping ([Lists]) -> Void) {
        var lists = [Lists]()
        
        db.collection("lists").order(by: "createdAt", descending: true).getDocuments { querySnapshot, error in
            if let error = error {
                print("error", error)
                completion([])
                return
            }
            
            for document in querySnapshot!.documents {
                let listData = document.data()
                
                let id = document.documentID
                let listName = listData["name"] as? String ?? ""
                let createdAt = listData["createdAt"] as? Date ?? Date.now
                
                let productsData = listData["products"] as? [[String: Any]] ?? []
                var products: [Products] = []
                
                for productData in productsData {
                    let productName = productData["name"] as? String ?? ""
                    let productQuantity = productData["quantity"] as? Int ?? 0
                    let productChecked = productData["checked"] as? Bool ?? false
                    let productId = productData["id"] as? String ?? ""
                    
                    let product = Products(id: productId, name: productName, checked: productChecked, quantity: productQuantity)
                    products.append(product)
                }
                
                let list = Lists(id: id, name: listName, createdAt: createdAt, products: products)
                lists.append(list)
            }
            
            completion(lists)
        }
        
    }
    
    func deleteList(id: String, completion: @escaping (Bool) -> Void) {
        db.collection("lists").document(id).delete { error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func addProduct(listId: String, product: Products, completion: @escaping (Bool?) -> Void) {
//        let id = "Nf4oJOFS72SftheZehU2"
//        let product1 = Products(id: "", name: "maca", checked: false, quantity: 2)
        
        let listRef = db.collection("lists").document(listId)
        
        listRef.getDocument { document, error in
            if let document = document, document.exists {
                let listData = document.data()
                var productsData = listData?["products"] as? [[String: Any]] ?? []
                
//                productsData[0]["name"] = "teste"
                
                let product2 = Products.toDictionnary(product: product)
                
                productsData.append(product2)
                                
                listRef.updateData(["products": productsData]) { err in
                    if err != nil {
//                        print(err?.localizedDescription)
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
    
    func updateCheckedProduct(listId: String, productId: String, checked: Bool, completion: @escaping (Bool) -> Void) {
        
        let listRef = db.collection("lists").document(listId)
        
        listRef.getDocument { document, error in
            if let document = document, document.exists {
                let listData = document.data()
                var productsData = listData?["products"] as? [[String: Any]] ?? []
                
                for i in 0..<productsData.count {
                    if productsData[i]["id"] as? String == productId {
                        productsData[i]["checked"] = checked
                    }
                }
                
                listRef.updateData(["products": productsData]) { err in
                    if err != nil {
//                        print(err?.localizedDescription)
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
        
    }
}
