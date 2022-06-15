//
//  HealthProfileModel.swift
//  Health
//
//  Created by Mohammad Salhab on 15/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import HealthKit

struct HealthProfileModel {
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double?
    var weightInKilograms: Double?
    var stepsCount: Double?
    var energyBurned: Double?
    
    var bodyMassIndex: Double? {
        guard
            let weightInKilograms = weightInKilograms,
            let heightInMeters = heightInMeters,
            heightInMeters > 0
        else {
            return nil
        }
        
        return (weightInKilograms/(heightInMeters*heightInMeters))
    }
}
