//
//  FirebaseRemoteConfigManager.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 12/12/2022.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfigManager {
    static let shared = FirebaseRemoteConfigManager()
    
    private init(){
        
    }
    
    let remoteConfig : RemoteConfig = {
        let config = RemoteConfig.remoteConfig()
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        config.configSettings = setting
        return config
    }()
    
    func setUpRemoteConfigDefaultValues(){
        let defaultValues = [
            "MainScreenAppBarTitle":"Grocery-App" as NSObject
        ]
        remoteConfig.setDefaults(defaultValues)
    }
    
    func fetchRemoteConfig(){
        remoteConfig.fetch { (status, error) in
            if status == .success {
                print("Config fetched")
                self.remoteConfig.activate { changed, error in
                    print("Configs updated successfully")
                }
            } else {
                print("Failed to fetch config")
            }
        }
    }
    
    func getToolBarName()->String{
        return remoteConfig.configValue(forKey: "MainScreenAppBarTitle").stringValue ?? ""
    }
    
}
