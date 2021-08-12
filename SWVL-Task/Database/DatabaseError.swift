//
//  DatabaseErrors.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import Foundation


enum DatabaseError: Error {
    case pathError
    case invalidData
    
    var description: String {
        switch self {
        case .pathError: return "Invalid Resource "
        case .invalidData: return "Data is Corrupted"
        }
    }
}
