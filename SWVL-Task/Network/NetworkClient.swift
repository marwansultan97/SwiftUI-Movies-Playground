//
//  NetworkClient.swift
//  SWVL-Task
//
//  Created by Marwan-Youxel on 10/02/2022.
//

import Foundation

protocol NetworkClient: AnyObject {
    
    func request<T: Codable>(model: T.Type, apiAction: ApiRequest, completion: @escaping (Result<T, NetworkError>) -> Void)    
}
