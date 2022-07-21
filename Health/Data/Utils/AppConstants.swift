//
//  AppConstants.swift
//  Health
//
//  Created by Mohammad Salhab on 17/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

class AppConstants {
    struct UserDefaults {
        static var deviceUUID = "deviceUUID"
        static var isUserSubscribed = "isUserSubscribed"
    }
    
    struct URLs {
        static var baseURL = "https://60618e8fac47190017a7114e.mockapi.io/api/v1/"
        struct EndPoints {
            static var customerSubscribe = "CustomerSubscribe"
            static var redeemPoints = "redeemPoints"
        }
    }
    
    struct storyboards {
        static var home = "Home"
    }
}
