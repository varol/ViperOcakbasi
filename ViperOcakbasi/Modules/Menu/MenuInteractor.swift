//
//  MenuInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import Foundation
import UIKit

protocol MenuInteractorInterface: class {
    func fetchMenuItems()
}

protocol MenuItemInteractorInterfaceOutput: class {
    func handleMenuItemResult(result: MenuItemResult)
}

class MenuInteractor {
    weak var output : MenuItemInteractorInterfaceOutput?
    
}

typealias RequestError = NetworkManager.RequestError
typealias MenuItemResult = Result <[MenuItem], RequestError>



extension MenuInteractor: MenuInteractorInterface {
    
    func fetchMenuItems() {
        let urlRequest = URLRequest(url: NetworkManager.sharedInstance.apiEndpoint)
        NetworkManager.sharedInstance.makeRequest(urlRequest) { (result: Result<[MenuItem], RequestError>) in
            switch result {
            case .success( _):
//                debugPrint("success value:", successValue.first?.content ?? "no data")
                self.output?.handleMenuItemResult(result: result)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    

    
}
