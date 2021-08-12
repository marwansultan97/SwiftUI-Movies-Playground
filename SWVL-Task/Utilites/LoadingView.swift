//
//  LoadingView.swift
//  SideMenu-Swiftui
//
//  Created by Marwan Osama on 26/06/2021.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isLoading = false
    
    var body: some View {
        ZStack(alignment: .center) {
            
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 10)
                .frame(width: 50, height: 50)
            
            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(Color.blue, lineWidth: 7)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
                .onAppear {
                    isLoading = true
                }
                .transition(.identity)
        }
        
    }
    
    //    var body: some View {
    //
    //
    //        VStack(alignment: .center, spacing: 15) {
    //
    //            ProgressView()
    //                .scaleEffect(1.4)
    //                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
    //
    //            Text("Please Wait!")
    //
    //        }
    //        .frame(width: 100, height: 90)
    //        .padding()
    //        .overlay(
    //            RoundedRectangle(cornerRadius: 30, style: .continuous)
    //                .fill(Color(.label).opacity(0.1))
    //        )
    //
    //    }
    

}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
