//
//  LocalDataClient.swift
//  SWVL-Task
//
//  Created by Marwan-Youxel on 10/02/2022.
//

import Foundation


protocol LocalDataClient {
    func fetchData<T: Codable>(resource: DatabaseResource, responseModel: T.Type, completionHandler: @escaping(Swift.Result<T, DatabaseError>) -> Void)
}
