//
//  UserSubscriptionViewModel.swift
//  Health
//
//  Created by Mohammad Salhab on 17/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UserSubscriptionViewModel {
    
    let disposeBag = DisposeBag()
    
    func subscribeUser(completion: @escaping ((CustomerSubscribeModel?) -> Void)) {
        let url = URL(string: AppConstants.URLs.baseURL + AppConstants.URLs.EndPoints.customerSubscribe)
        var resource = Resource<CustomerSubscribeModel>(url: url!)
        resource.httpMethod = .post
        let subscribeModel = CustomerSubscribeModel(deviceID: UIDevice.generateNewDeviceUUID(), deviceType: "iOS", deviceName: "Salhab")
        do {
            let data = try JSONEncoder().encode(subscribeModel)
            resource.body = data
            URLRequest.load(resource: resource)
                .subscribe(onNext: { response in
                    completion(response)
                }).disposed(by: disposeBag)
        } catch let err {
            completion(nil)
        }
    }
}
