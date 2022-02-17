//
//  MockMoviesLocalData.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 15/02/2022.
//

import Foundation
@testable import SWVL_Task


class MockMoviesLocalData: LocalDataClient {
    
    
    var error: DatabaseError?
    
    
    func fetchData<T: Codable>(resource: DatabaseResource, responseModel: T.Type, completionHandler: @escaping (Result<T, DatabaseError>) -> Void) {
        
        if let error = error {
            completionHandler(.failure(error))
            return
        } else {
            guard let movies = Movies(movies: [.init(title: "123", year: 2020, cast: ["asd"], genres: ["asd"], rating: 10)]) as? T else {
                completionHandler(.failure(.invalidData))
                return
            }
            completionHandler(.success(movies))
        }
        
    }
    
    
    
    
    
}
