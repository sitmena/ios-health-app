//
//  MotionActivityAssistant.swift
//  Health
//
//  Created by Mohammad Salhab on 30/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import CoreMotion

class MotionActivityAssistant {
    
    class func getMotionStatus() {
        /// Provides to create an instance of the CMMotionActivityManager.
        let activityManager = CMMotionActivityManager()
        /// Provides to create an instance of the CMPedometer.
        let pedometer = CMPedometer()
        if CMMotionActivityManager.isActivityAvailable() {
            activityManager.startActivityUpdates(to: OperationQueue.main) { (activity: CMMotionActivity?) in
                guard let activity = activity else { return }
                DispatchQueue.main.async {
                    if activity.stationary {
                        print("Stationary")
                    } else if activity.walking {
                        print("Walking")
                    } else if activity.running {
                        print("Running")
                    } else if activity.automotive {
                        print("Automotive")
                    }
                }
            }
        }
        
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                guard let pedometerData = pedometerData, error == nil else { return }
                
                DispatchQueue.main.async {
                    print(pedometerData.numberOfSteps.intValue)
                }
            }
        }
    }
}
