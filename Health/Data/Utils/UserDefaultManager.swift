//
//  UserDefaultManager.swift
//  Health
//
//  Created by Mohammad Salhab on 17/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

final class UserDefaultManager: NSObject {
    static let shared = UserDefaultManager()
    
    let userDefaults = UserDefaults.standard
    
    private override init() {
        super.init()
    }
    
    func getUUID() -> String? {
        return userDefaults.string(forKey: AppConstants.UserDefaults.deviceUUID)
    }
    
    func setUUID(newUUID: String) {
        userDefaults.set(newUUID, forKey: AppConstants.UserDefaults.deviceUUID)
    }
    
    func isUserSubscribed() -> Bool {
        return userDefaults.bool(forKey: AppConstants.UserDefaults.isUserSubscribed)
    }
    
    func setUserIsSubscribed() {
        userDefaults.set(true, forKey: AppConstants.UserDefaults.isUserSubscribed)
    }
}
