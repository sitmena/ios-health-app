//
//  RedeemConfigurationModel.swift
//  Health
//
//  Created by Mohammad Salhab on 20/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

// MARK: - RedeemConfigurationModel
struct RedeemConfigurationModel: Decodable {
    let bankID, bankName, factor: String?
    let pointTarget, minimumPointsToBeRedeemed, maximumPointsToBeRedeemed, pushInterval: Int?

    enum CodingKeys: String, CodingKey {
        case bankID = "bankId"
        case bankName, factor, pointTarget, minimumPointsToBeRedeemed, maximumPointsToBeRedeemed, pushInterval
    }
}

