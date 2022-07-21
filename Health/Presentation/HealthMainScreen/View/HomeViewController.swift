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
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
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
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var stepsProgressView: UIProgressView!
    
    
    // MARK: - View Lifecycle
    fileprivate func healthKitPermission() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            print("HealthKit Successfully Authorized.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // moved from appdelegate to here
        healthKitPermission()
        
        FetchHealthData()
        if UserDefaultManager.shared.isUserSubscribed() {
            // MARK: -
        } else {
            // MARK: - Subscribe User
            subscribeViewModel.subscribeUser { result in
                if let result = result {
                    
                } else {
                    
                }
            }
        }
        
        redeemButton.rx.tap.bind {
            let url = URL(string: AppConstants.URLs.baseURL + AppConstants.URLs.EndPoints.redeemPoints)
            var resource = Resource<CustomerSubscribeModel>(url: url!)
            resource.httpMethod = .post
            let redeemModel = CustomerSubscribeModel(deviceID: UIDevice.getDeviceUUID(), deviceType: "iOS", deviceName: "iPhone")
            do {
                let data = try JSONEncoder().encode(redeemModel)
                resource.body = data
                URLRequest.load(resource: resource)
                    .subscribe(onNext: { response in
                        print(response)
                    }).disposed(by: self.disposeBag)
            } catch let err {
                print(err)
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
                // MARK: - todo make sure to sync data with server if noOfSteps is changed and within the interval retrieved from the configs.
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
    
    private func redeemPoints() {
        
    }
}
