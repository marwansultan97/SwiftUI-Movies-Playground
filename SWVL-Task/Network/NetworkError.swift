//
//  NetworkError.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation
import Alamofire

enum NetworkError: Error, Equatable {
    
    case cannotParseJson
    case cannotParseErrorJSON
    case unknown
    case network(message: String, code: Int)
    case server(message: String, code: Int?)
    case cannotRefreshToken
    case timeout
    case requestCancelled
    
    init(response: AFDataResponse<Any>) {
        if case .explicitlyCancelled = response.error {
            self = .requestCancelled
            return
        }
        
        if let error = response.error?.underlyingError as NSError? {
            switch error.code {
            case NSURLErrorCancelled:
                self = .requestCancelled
                return
                
            case NSURLErrorNotConnectedToInternet:
                self = .network(message: error.localizedDescription, code: error.code)
                return
                
            case NSURLErrorTimedOut:
                self = .timeout
                return
                
            default:
                break
            }
        }
        
        guard let serverResponse = response.response else {
            self = .unknown
            return
        }
        
        let statusCode = serverResponse.statusCode
        guard let serverData = response.data else {
            let message = response.error?.localizedDescription ?? "Server Error No Data"
            self = .server(message: message, code: nil)
            return
        }
        
        let json = try? JSONSerialization.jsonObject(with: serverData, options: []) as? [String: Any]
        guard let serverErrorMessage = json?["message"] as? String else {
            self = .cannotParseErrorJSON
            return
        }
        
        self = .server(message: serverErrorMessage, code: statusCode)
        
    }
    
    
    
    var errorDescription: String {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .cannotParseJson:
            return "Cannot Parse JSON"
        case .timeout:
            return "Timeout"
        case .cannotParseErrorJSON:
            return "Can't Parse Error Message"
        case .network(let message, _):
            return "Network: \(message)"
        case .server(let message, _):
            return "Server: \(message)"
        case .requestCancelled:
            return "Request Cancelled"
        case .cannotRefreshToken:
            return "Can't Refresh Token"
        }
    }
    
    
    
}
