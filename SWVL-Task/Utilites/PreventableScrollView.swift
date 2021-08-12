//
//  PreventableScrollView.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//

import SwiftUI


struct PreventableScrollView<Content>: View where Content: View {
    
    @Binding var canScroll: Bool
    var content: () -> Content
    
    var body: some View {
        if canScroll {
            ScrollView(.vertical, showsIndicators: false, content: content)
        } else {
            VStack(spacing: 5) {
                content()
            }
            .padding(.top, -40)
        }
    }
}
