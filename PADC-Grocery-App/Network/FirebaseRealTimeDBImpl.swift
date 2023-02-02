//
//  FirebaseRealTimeDBImpl.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 13/09/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage

class FirebaseRealTimeDBImpl: FirebaseApi {
    
    var ref: DatabaseReference = Database.database().reference()
    
    var storage = Storage.storage()

    func getAllGroceries(success: @escaping ([GroceryVO]) -> Void, failure: @escaping (String) -> Void) {
        ref.child("gorceries").observe(DataEventType.value) { dataSnapShot in
            var groceriesList: [GroceryVO] = []
            dataSnapShot.children.forEach { singleSnapShot in
                var grocery = GroceryVO()
                let groceriesDictionary = ( singleSnapShot as? DataSnapshot )?.value as? [String:AnyObject] ?? [:]
                grocery.name = groceriesDictionary["name"] as? String
                grocery.description = groceriesDictionary["description"] as? String
                grocery.amount = groceriesDictionary["amount"] as? String

                groceriesList.append(grocery)
            }
            success(groceriesList)
        }
        
                
    }
    
    func addGrocery(grocery: GroceryVO) {
        ref.child("gorceries").child(grocery.name ?? "").setValue([
            "name":grocery.name ?? "default name",
            "description":grocery.description ?? "default description",
            "amount":grocery.amount ?? "default amount",
            "image":grocery.image ?? ""
        ])
        
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        ref.child("gorceries").child(grocery.name ?? "").removeValue()
    }
    
    func uploadImage(imageData: Data, grocery: GroceryVO) {
        
        print("====>Reached Upload Image")
        
        let storageRef = storage.reference()
        let groceryImageRef = storageRef.child("image/\(UUID().uuidString).jpg")
        
        groceryImageRef.putData(imageData) { (metadata,err) in
            if let err = err {
                print("====>Fail to Upload Image \(err.localizedDescription)")
            } else {
                print("====>Successfully uploaded Image")
            }
            
            groceryImageRef.downloadURL { url, err in
                guard let downloadedURL = url else{
                    return
                }
                let imageurl = downloadedURL.absoluteString
                var newgrocery = GroceryVO()
                newgrocery.image = imageurl
                newgrocery.name = grocery.name
                newgrocery.amount = grocery.amount
                newgrocery.description = grocery.description
                self.addGrocery(grocery: newgrocery)
            }
        }
    }
    
}
