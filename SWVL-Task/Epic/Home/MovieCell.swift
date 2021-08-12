//
//  MovieCell.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import SwiftUI

struct MovieCell: View {
    
    var name: String
    var rating: Int
    var year: Int
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.system(size: 25, weight: .semibold))
                    
                Text("Year: \(year.description)")
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding(.leading, 10)
            
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(0..<rating, id: \.self) { _ in
                   Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                }
            }
            .padding(.trailing, 20)
            
        }
        
        
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(name: "Avengers", rating: 5, year: 2015)
    }
}
