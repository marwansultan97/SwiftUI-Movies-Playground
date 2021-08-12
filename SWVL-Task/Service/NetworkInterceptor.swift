//
//  NetworkInterceptor.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation
import Alamofire


class NetworkInterceptor: RequestInterceptor {
    
    let retryCount = 3
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard  request.retryCount < retryCount else {
            completion(.doNotRetry)
            return
        }
        
        completion(.retry)
        
        
    }
    
    
    
}
