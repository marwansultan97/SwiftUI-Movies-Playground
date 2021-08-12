//
//  NetworkError.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation

enum NetworkError: Error {
    
    case checkStatusCode(statusCode: Int)
    case corruptedData
    case unknown
    
    
    var errorObject: GeneralError {
        switch self {
        case .unknown:
            return GeneralError(status: 0, message: "Unknown Error")
        case .corruptedData:
            return GeneralError(status: 0, message: "Corrupted Data")
        case .checkStatusCode(let statusCode):
            if statusCode == 401 {
                return GeneralError(status: statusCode, message: "Unauthorized")
            } else if statusCode == 404 {
                return GeneralError(status: statusCode, message: "Not Found")
            } else if statusCode >= 500 {
                return GeneralError(status: statusCode, message: "Internal Server Error")
            } else {
                return GeneralError(status: statusCode, message: "Unknown")
            }
            
        
        }
    }
    
    
    
}
