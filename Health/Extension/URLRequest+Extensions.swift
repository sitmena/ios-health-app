//
//  URLRequest+Extensions.swift
//  Health
//
//  Created by Mohammad Salhab on 17/07/2022.
//  Copyright © 2022 Sitech. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Decodable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    var header: [String: String] = ["Content-Type": "application/json"]
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                var request = URLRequest(url: url)
                request.httpMethod = resource.httpMethod.rawValue
                request.httpBody = resource.body
                request.allHTTPHeaderFields = resource.header
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }.catch { err in
                print(err)
                return try JSONDecoder().decode(T.self, from: Data(base64Encoded: "")!) as! Observable<T>
            }
    }
}
