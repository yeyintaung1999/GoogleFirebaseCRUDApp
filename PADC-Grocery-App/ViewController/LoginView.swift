//
//  LoginView.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 12/12/2022.
//

import SwiftUI
import FirebaseAnalytics
import Firebase

struct LoginView: View {
    
    let api = GroceryModelImpl()
    
    @State var emailValue: String = ""
    @State var passwordValue: String = ""
    @State var isLogined : Bool = false
    
    init(){
        Analytics.logEvent(SCREEN_LOGIN, parameters: nil)
        api.setUpRemoteConfigWithDefaultValues()
        api.fetchRemoteConfig()
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                Text("Welcome")
                TextField("Enter Email", text: $emailValue)
                TextField("Enter password", text: $passwordValue)
                Button("LogIn") {
                    api.login(email: emailValue, password: passwordValue) {
                        
                        Analytics.logEvent(TAP_LOGIN, parameters: [PARAMETER_EMAIL:emailValue])
                        
                        self.isLogined = true
                    }
                }
                .frame(width: 100, height: 50, alignment: .center)
            }.padding([.leading,.trailing], 50)
        }.sheet(isPresented: $isLogined) {
            //MainScreenView(isPresented: $isLogined)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
