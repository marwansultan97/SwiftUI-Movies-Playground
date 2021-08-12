//
//  UIApplication+Extension.swift
//  SideMenu-Swiftui
//
//  Created by Marwan Osama on 03/07/2021.
//

import SwiftUI


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

