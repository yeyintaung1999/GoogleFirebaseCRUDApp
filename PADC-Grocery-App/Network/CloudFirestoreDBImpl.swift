//
//  CloudFirestoreDBImpl.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 01/12/2022.
//

import Foundation
import FirebaseFirestore

class CloudFirestoreDBImpl: FirebaseApi {
    
    var ref = Firestore.firestore()
    
    func getAllGroceries(success: @escaping ([GroceryVO]) -> Void, failure: @escaping (String) -> Void) {
        ref.collection("Groceries").addSnapshotListener { snapshot, error in
            var groceryList : [GroceryVO] = []
            
            snapshot?.documents.forEach({ singleSnapshot in
                var grocery = GroceryVO()
                grocery.name = singleSnapshot["name"] as? String
                grocery.amount = singleSnapshot["amount"] as? String
                grocery.description = singleSnapshot["description"] as? String
                groceryList.append(grocery)
            })
            success(groceryList)
        }

    }
    
    func addGrocery(grocery: GroceryVO) {
        let groceryDictionary: [String: Any] = [
            "name":grocery.name ?? "",
            "amount":grocery.amount ?? "",
            "description":grocery.description ?? ""
        ]
        
        ref.collection("Groceries").document(grocery.name ?? "")
            .setData(groceryDictionary)
        
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        ref.collection("Groceries").document(grocery.name ?? "").delete()

    }
    
    func uploadImage(imageData: Data, grocery: GroceryVO) {
        
        
    }
    
}
