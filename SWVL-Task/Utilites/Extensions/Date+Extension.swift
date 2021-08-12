//
//  Date+Extension.swift
//  SideMenu-Swiftui
//
//  Created by Marwan Osama on 30/06/2021.
//

import Foundation


extension Date {
    
    
    func convertDateToString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}
