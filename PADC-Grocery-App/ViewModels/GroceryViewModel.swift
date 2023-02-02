//
//  GroceryViewModel.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 14/09/2022.
//

import Foundation

class GroceryViewModel: ObservableObject {
    //model
    let groceryModel: GroceryModel = GroceryModelImpl()
    
    //data
    @Published var groceries : [GroceryVO] = []
    @Published var isPopOverShown : Bool = false
    @Published var groceryName: String = ""
    @Published var groceryDescription: String = ""
    @Published var groceryAmount: String = ""
    @Published var groceryImage: String = ""
    
    init() {
        groceryModel.getAllGroceries { (groceries) in
            self.groceries = groceries
        } failure: { (error) in
            print(error)
        }
    }
    
    func addGrocery(){
        var grocery: GroceryVO = GroceryVO()
        grocery.name = groceryName
        grocery.description = groceryDescription
        grocery.amount = groceryAmount
        groceryModel.addGrocery(grocery: grocery)
    }
    
    func deleteGrocery(grocery: GroceryVO){
        groceryModel.deleteGrocery(grocery: grocery)
    }
    
    func editGrocery(name: String, description: String, amount: String){
        self.groceryName = name
        self.groceryDescription = description
        self.groceryAmount = amount
    }
    
    func uploadImage(imageData: Data){
        var grocery = GroceryVO()
        grocery.name = groceryName
        grocery.amount = groceryAmount
        grocery.description = groceryDescription
        print("ImageData in ViewModel ==> \(self.groceryName) \(imageData)")
        groceryModel.uploadImage(imageData: imageData, grocery: grocery)
    }
    
}
