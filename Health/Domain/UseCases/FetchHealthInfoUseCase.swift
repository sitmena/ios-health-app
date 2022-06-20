//
//  FetchHealthInfoUseCase.swift
//  Health
//
//  Created by Mohammad Salhab on 15/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation

protocol ReceivedData {
    func steps()
    func calories()
}

class FetchHealthInfoUseCase {
    
    var healthProfile = HealthProfileModel()
    
    func loadDailySteps(_ completion: @escaping (HealthProfileModel) -> Void) {
        ProfileDataStore.getTodaysSteps { [weak self] stepsCount in
            guard let `self` = self else { return }
            
            self.healthProfile.stepsCount = Int(stepsCount.rounded())
            completion(self.healthProfile)
        }
    }
    
    func loadEnergyBurned(_ completion: @escaping (HealthProfileModel) -> Void) {
        ProfileDataStore.getEnergyBurned { [weak self] caloriesBurned in
            guard let `self` = self else { return }
            self.healthProfile.energyBurned = Int(caloriesBurned.rounded())
            completion(self.healthProfile)
        }
    }
}
