//
//  String+Extension.swift
//  SideMenu-Swiftui
//
//  Created by Marwan Osama on 26/06/2021.
//

import Foundation

extension String {
    
    func trimString() -> String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    var length: Int {
        return self.count
    }
    
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }


}
