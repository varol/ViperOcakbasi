//
//  NetworkManager.swift
//  ViperOcakbasi
//
//  Created by VAROL AKSOY on 2.01.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//
import Foundation


class NetworkManager: NSObject {
    let apiEndpoint = URL(string: "http://kerimcaglar.com/yemek-tarifi")!
    

    static let sharedInstance: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()

    enum RequestError: Error {
        case clientError
        case serverError
        case noData
        case dataDecodingError
            
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
    
    private func decodedData<T: Decodable>(_ data: Data) -> T? {
        if T.self is String.Type {
            return String(data: data, encoding: .utf8) as? T
        } else {
                let decoder = JSONDecoder()
                return try? decoder.decode(T.self, from: data)

            //            return try? JSONSerialization.jsonObject(with: data) as? T
        }
    }

}
