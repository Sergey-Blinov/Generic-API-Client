//
//  ViewController.swift
//  Generic API Client
//
//  Created by Sergey on 11/17/18.
//  Copyright © 2018 sblinov.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let endpoint = TestCarEndpoint()
        
        _ = TestClient().queueRequest(for: endpoint) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                
            case .success(let result):
                debugPrint(result)
            }
        }
    }
}


