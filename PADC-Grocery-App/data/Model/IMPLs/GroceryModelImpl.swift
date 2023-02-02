//
//  GroceryModelImpl.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 14/09/2022.
//

import Foundation
import FirebaseFirestore

class GroceryModelImpl: GroceryModel {
    
    let firebase_api: FirebaseApi = FirebaseRealTimeDBImpl()
    //let firebase_api: FirebaseApi = CloudFirestoreDBImpl()
    
    let remoteConfig_api = FirebaseRemoteConfigManager.shared
    
    let auth_api = FirebaseAuthManager.shared
    
    func getAllGroceries(success: @escaping ([GroceryVO]) -> Void, failure: @escaping (String) -> Void) {
        firebase_api.getAllGroceries(success: success, failure: failure)
    }
    
    func addGrocery(grocery: GroceryVO) {
        firebase_api.addGrocery(grocery: grocery)
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        firebase_api.deleteGrocery(grocery: grocery)
    }
    
    func uploadImage(imageData: Data, grocery: GroceryVO) {
        firebase_api.uploadImage(imageData: imageData, grocery: grocery)
    }
    
    func setUpRemoteConfigWithDefaultValues() {
        remoteConfig_api.setUpRemoteConfigDefaultValues()
    }
    
    func fetchRemoteConfig() {
        remoteConfig_api.fetchRemoteConfig()
    }
    
    func getAppNameFromRemoteConfig()->String {
        let result = remoteConfig_api.getToolBarName()
        return result
    }
    
    func login(email: String, password: String, success: @escaping () -> Void) {
        auth_api.login(email: email, password: password, success: success)
    }
    
}
