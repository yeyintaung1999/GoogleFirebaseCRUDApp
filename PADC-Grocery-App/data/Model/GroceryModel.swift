//
//  GroceryModel.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 13/09/2022.
//

import Foundation

protocol GroceryModel {
    
    func getAllGroceries( success: @escaping([GroceryVO])->Void, failure: @escaping(String)->Void )
    func addGrocery(grocery: GroceryVO)
    func deleteGrocery(grocery: GroceryVO)
    func uploadImage(imageData: Data, grocery: GroceryVO)
    func login(email: String, password: String, success: @escaping ()->Void)
    func setUpRemoteConfigWithDefaultValues()
    func fetchRemoteConfig()
    func getAppNameFromRemoteConfig()->String
    
    
}

