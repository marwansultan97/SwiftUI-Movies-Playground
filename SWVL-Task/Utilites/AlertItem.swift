//
//  AlertItem.swift
//  SideMenu-Swiftui
//
//  Created by Marwan Osama on 26/06/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text = Text("Health Care")
    var message: Text
    var dismissButton: Alert.Button?
    var secondaryButton: Alert.Button?
}
