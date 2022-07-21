//
//  customerLastSynchronizedData.swift
//  Health
//
//  Created by Mohammad Salhab on 20/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

struct CustomerLastSynchronizedDataModel: Decodable {
    let fitnessData: FitnessData?
    let redeemConfiguration: RedeemConfiguration?
}

// MARK: - FitnessData
struct FitnessData: Codable {
    let numberOfSteps: Int?
    let fromDate: Date?
    let id, deviceID: String?
    let toDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case numberOfSteps, fromDate, id
        case deviceID = "deviceId"
        case toDate
    }
}

// MARK: - RedeemConfiguration
struct RedeemConfiguration: Codable {
    let bankID, bankName, factor: String?
    let pointTarget, minimumPointsToBeRedeemed, maximumPointsToBeRedeemed, pushInterval: Int?
    
    enum CodingKeys: String, CodingKey {
        case bankID = "bankId"
        case bankName, factor, pointTarget, minimumPointsToBeRedeemed, maximumPointsToBeRedeemed, pushInterval
    }
}
