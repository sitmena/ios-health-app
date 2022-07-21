//
//  FitnessDataModel.swift
//  Health
//
//  Created by Mohammad Salhab on 20/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

// MARK: - FitnessDataModel
struct FitnessDataModel: Decodable {
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
