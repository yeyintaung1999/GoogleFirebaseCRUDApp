//
//  FirebaseAuthManager.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 13/12/2022.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager{
    
    static let shared = FirebaseAuthManager()
    
    private init(){
        
    }
    
    let auth = Auth.auth()
    
    func login(email: String,password: String, success: @escaping ()->Void){
        auth.signIn(withEmail: email, password: password) { dataResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                success()
            }
        }
    }
    
}
