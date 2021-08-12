//
//  AFRequest.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation
import Alamofire


class AFRequest {
    
    
    static func request<T: Decodable>(model: T.Type, request: ApiRequest, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        AF.request(request, interceptor: NetworkInterceptor())
            .validate(statusCode: 200...300)
            .responseData { response in
                
                guard let statusCode = (response.response?.statusCode) else {
                    completion(.failure(.unknown))
                    return
                }

                switch response.result {
                case .success(let data):
                    guard !data.isEmpty else {
                        completion(.failure(.unknown))
                        return
                    }

                    let decoder = JSONDecoder()

                    guard let dataObject = try? decoder.decode(T.self, from: data) else {
                        completion(.failure(.corruptedData))
                        return
                    }
                    completion(.success(dataObject))

                case .failure(_):
                    completion(.failure(.checkStatusCode(statusCode: statusCode)))
                }
               
                
                
                
                
                
                
            }
    }
    
    
}



