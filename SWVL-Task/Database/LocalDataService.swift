//
//  LocalDataService.swift
//  SWVL-Task
//
//  Created by Marwan-Youxel on 10/02/2022.
//

import Foundation

class LocalDataService: LocalDataClient {
    
    
    func fetchData<T: Codable>(resource: DatabaseResource, responseModel: T.Type, completionHandler: @escaping (Result<T, DatabaseError>) -> Void) {
        
        if let url = Bundle.main.url(forResource: resource.rawValue, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completionHandler(.success(jsonData))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        } else {
            completionHandler(.failure(.pathError))
        }

        
    }
    
    
    
    
}
