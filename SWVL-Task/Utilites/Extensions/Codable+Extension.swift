//
//  Codable+Extension.swift
//  SwiftUI-Courier
//
//  Created by Marwan Osama on 13/07/2021.
//

import Foundation


extension Encodable {
    
    func asDictionary() -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return [:] }
        return json
    }
    
}
