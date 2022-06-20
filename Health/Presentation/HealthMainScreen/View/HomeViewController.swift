//
//  HomeViewController.swift
//  Health
//
//  Created by Mohammad Salhab on 09/06/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import UIKit
import Resolver

class HomeViewController: UIViewController {
    
    // MARK: - ViewModels
    @LazyInjected
    private var viewModel: HealthProfileViewModel
    
    
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
        viewModel.fetchHealthProfile = { [weak self] healthProfile in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.stepsCountLabel.text = healthProfile.stepsCount?.description
                self.caloriesBurnedLabel.text = healthProfile.energyBurned?.description
                self.updateHealthBar(healthProfile.stepsCount ?? 0)
            }
        }
        viewModel.requestHealthData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.requestHealthData()
    }
    
    private func updateHealthBar(_ stepsCount: Int) {
        currentValueLabel.text = (stepsCount % 1000).description
        stepsProgressView.progress = Float(stepsCount % 1000) / 1000
        currentValueView.frame.origin.x = stepsProgressView.frame.width * CGFloat(stepsProgressView.progress) - currentValueView.bounds.width / 2
        
    }
}
