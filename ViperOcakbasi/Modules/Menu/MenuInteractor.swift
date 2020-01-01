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
    let apiEndpoint = URL(string: "https://varol.us/jsonformatter.json")
    weak var output : MenuItemInteractorInterfaceOutput?
}

typealias MenuItemResult = Result <MenuItem, RequestError>

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
        
}


extension MenuInteractor: MenuInteractorInterface {
    
    func fetchMenuItems() {
        let urlRequest = URLRequest(url: apiEndpoint!)
        makeRequest(urlRequest) { (result: Result<MenuItem, RequestError>) in
            
            switch result {
            case .success(let successValue):
                print("succes", successValue)
                // handle success
            case .failure(let error):
                // handle error
                print(error)
            }
            
        }
    }
    
    func makeRequest<T: Decodable>(_ request: URLRequest, resultHandler: @escaping (Result<T, RequestError>) -> Void) {
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }

            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                return
            }
            print(response)

            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }

            guard let decodedData: T = self.decodedData(data) else {
                resultHandler(.failure(.dataDecodingError))
                return
            }
            resultHandler(.success(decodedData))

        }

        urlTask.resume()
    }
    
    private func decodedData<T: Any>(_ data: Data) -> T? {
        if T.self is String.Type {
            return String(data: data, encoding: .utf8) as? T
        } else {

            return try? JSONSerialization.jsonObject(with: data) as? T
        }
    }
    

    
}
