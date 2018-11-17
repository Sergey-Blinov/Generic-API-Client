//
//  TestAPI.swift
//  Generik API Client
//
//  Created by Sergey on 11/17/18.
//  Copyright © 2018 sblinov.com. All rights reserved.
//

import Foundation

struct TestCar: Codable {
    let modelName: String
    let name: String
}

struct TestCarEndpoint: EndPoint {
    typealias Response = [TestCar]
    var httpMethod: HTTPMethod { return .get }
    var path: String { return "/cars.json" }
}

class TestClient: APIClient {
    private var host: String
    private var scheme: String
    private var operationQueue: OperationQueue
    
    var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.host = host
        components.scheme = scheme
        
        return components
    }
    
    var session: URLSession {
        return URLSession.shared
    }
    
    init(host: String = "www.codetalk.de",
         scheme: String = "http",
         queue: OperationQueue = OperationQueue()) {
        self.host = host
        self.scheme = scheme
        self.operationQueue = queue
    }
    
    func queueRequest<T:EndPoint>(for resource: T, completion: @escaping (APIResult<T>) -> Void) -> Operation {
        let operation = NetworkOperation<T>(client: self, resource: resource, completion: completion)
        defer { self.operationQueue.addOperation(operation) }
        
        return operation
    }
}


