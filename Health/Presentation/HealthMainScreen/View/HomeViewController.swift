//
//  HomeViewController.swift
//  Health
//
//  Created by Mohammad Salhab on 09/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import UIKit
import Resolver
import CoreMotion

class HomeViewController: UIViewController {
    
    // MARK: - ViewModels
    @LazyInjected
    private var viewModel: HealthProfileViewModel
    private var subscribeViewModel = UserSubscriptionViewModel()
    
    /// Provides to create an instance of the CMMotionActivityManager.
    let activityManager = CMMotionActivityManager()
    
    private var noOfSteps: Int = 0 {
        didSet {
            self.stepsCountLabel.text = noOfSteps.description
            self.updateHealthBar(noOfSteps)
        }
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    @IBOutlet weak var totalPointsBalanceLabel: UILabel!
    @IBOutlet weak var currentValueView: UIView!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var stepsProgressView: UIProgressView!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FetchHealthData()
        if UserDefaultManager.shared.isUserSubscribed() {
            
        } else {
            // MARK: - Subscribe User
            subscribeViewModel.subscribeUser { result in
                if let result = result {
                    
                } else {
                    
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.requestHealthData()
    }
    
    private func updateHealthBar(_ stepsCount: Int) {
        currentValueLabel.text = (stepsCount % 1000).description
        stepsProgressView.progress = Float(stepsCount % 1000) / 1000
        currentValueView.transform = CGAffineTransform(translationX: stepsProgressView.frame.width * CGFloat(stepsProgressView.progress) - currentValueView.bounds.width / 2, y: 0)
    }
    
    private func FetchHealthData() {
        viewModel.fetchHealthProfile = { [weak self] healthProfile in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.noOfSteps = healthProfile.stepsCount ?? 0
                self.caloriesBurnedLabel.text = healthProfile.energyBurned?.description
            }
        }
        viewModel.requestHealthData()
        
        if CMMotionActivityManager.isActivityAvailable() {
            activityManager.startActivityUpdates(to: OperationQueue.main) { (activity: CMMotionActivity?) in
                guard let activity = activity else { return }
                DispatchQueue.main.async {
                    if activity.running || activity.walking {
                        print("not stationary")
                        self.viewModel.requestHealthData()
                    }
                }
            }
        }
    }
    
    private func subsribeUser() {
        
    }
}
