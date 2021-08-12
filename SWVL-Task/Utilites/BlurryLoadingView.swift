//
//  LoadingView2.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//
import SwiftUI

struct BlurryLoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    
                    Text("Loading...")
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 2).cornerRadius(25)
                .background(Color.secondary.colorInvert().frame(width: 120, height: 100).cornerRadius(25))
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}
