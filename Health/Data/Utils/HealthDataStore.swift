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
        
        //let now = Date()
        
//        var component = DateComponents()
//        component.month = 6
//        component.hour = 1
//        component.day = 27
//        component.year = 2022
        
//        let date = Calendar.current.date(from: component)
        //DateComponents(
        
        // MARK: - replace "NSDate().timeIntervalSince1970" to unix time stamp
        let now = Date(timeIntervalSince1970: NSDate().timeIntervalSince1970)
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
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
    
    // MARK: - todo - create another method to fetch steps from specific time

    class func getEnergyBurned(completion: @escaping (Double) -> Void) {
        let healthStore = HKHealthStore()
        let energyQuantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )

        
        let query = HKStatisticsQuery(
            quantityType: energyQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print(error)
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.kilocalorie()))
        }
        
        healthStore.execute(query)
    }
    
}
