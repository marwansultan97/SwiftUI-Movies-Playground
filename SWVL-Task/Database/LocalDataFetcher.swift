//
//  LocalDataFetcher.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import Foundation

class LocalDataFetcher {
    
    static func fetchData<T: Codable>(resource: DatabaseResource, responseModel: T.Type, completionHandler: @escaping(Result<T, DatabaseError>) -> Void) {
        
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
