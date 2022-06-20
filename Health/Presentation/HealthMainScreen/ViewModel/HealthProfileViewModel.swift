//
//  HealthProfileViewModel.swift
//  Health
//
//  Created by Mohammad Salhab on 16/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation
import RxSwift

class HealthProfileViewModel {
    
    var healthUseCase = FetchHealthInfoUseCase()
    public var fetchHealthProfile: ((HealthProfileModel) -> Void)?
    
    func requestHealthData() {
        healthUseCase.loadDailySteps { [weak self] healthProfile in
            guard let `self` = self else { return }
            self.fetchHealthProfile?(healthProfile)
        }
        
        healthUseCase.loadEnergyBurned { [weak self] healthProfile in
            guard let `self` = self else { return }
            self.fetchHealthProfile?(healthProfile)
        }
    }
    
}
