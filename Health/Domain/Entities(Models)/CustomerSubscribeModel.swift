//
//  CustomerSubscribeModel.swift
//  Health
//
//  Created by Mohammad Salhab on 17/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

// MARK: - CustomerSubscribeModel
struct CustomerSubscribeModel: Codable {
    let deviceID, deviceType, deviceName: String?

    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case deviceType, deviceName
    }
}
