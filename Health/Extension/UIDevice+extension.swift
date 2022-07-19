//
//  UIDevice+extension.swift
//  Health
//
//  Created by Mohammad Salhab on 07/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    static func getDeviceUUID() -> String? {
        guard let deviceUUID = UserDefaultManager.shared.getUUID() else { return nil }
        return deviceUUID
    }
    
    static func generateNewDeviceUUID() -> String {
        let uuid = NSUUID()
        UserDefaultManager.shared.setUUID(newUUID: uuid.uuidString)
        return uuid.uuidString
    }
}
