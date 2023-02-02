//
//  FirebaseApi.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 13/09/2022.
//

import Foundation

protocol FirebaseApi {
    func getAllGroceries( success: @escaping([GroceryVO])->Void, failure: @escaping(String)->Void)
    func addGrocery(grocery: GroceryVO)
    func deleteGrocery(grocery: GroceryVO)
    func uploadImage(imageData: Data, grocery: GroceryVO)
}
