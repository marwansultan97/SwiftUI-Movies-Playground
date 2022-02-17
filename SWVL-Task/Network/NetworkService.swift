//
//  NetworkService.swift
//  SWVL-Task
//
//  Created by Marwan-Youxel on 10/02/2022.
//

import Foundation
import Alamofire

class NetworkService: NSObject, NetworkClient {
    
    private var session: Session
    
    init(session: Session = Session(configuration: .default, interceptor: NetworkInterceptor())) {
        self.session = session
    }
        
    func request<T: Codable>(model: T.Type, apiAction: ApiRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.request(apiAction)
            .validate()
            .responseJSON { [weak self] response in
                guard let self = self else { return }
                let result = self.handleResponse(response: response, model: model.self)
                completion(result)
                
            }
    }
    
    
    
}

// MARK: - Helpers
extension NetworkService {
    
    private func handleResponse<T: Codable>(response: AFDataResponse<Any>, model: T.Type) -> Result<T, NetworkError> {
        
        var result: Result<T, NetworkError>
        
        switch response.result {
        case .success:
            guard let data = response.data else {
                result = .failure(NetworkError.init(response: response))
                return result
            }
            guard let objc = try? JSONDecoder().decode(model.self, from: data) else {
                result = .failure(.cannotParseJson)
                return result
            }
            
            result = .success(objc)
            
        case .failure:
            result = .failure(NetworkError.init(response: response))
        }
        
        return result
    }
}
