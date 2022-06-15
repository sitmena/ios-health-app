//
//  HealthDataStore.swift
//  Health
//
//  Created by Mohammad Salhab on 13/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import HealthKit

class ProfileDataStore {
    
    class func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let healthStore = HKHealthStore()
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
//        let testTime = Calendar.current.date
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
//        let predicateA = HKQuery.predicateForSamples(
//            withStart: ,
//            end: now,
//            options: .strictStartDate
//        )
        
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print(error)
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
}