//
//  MovieDetailsView.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    
    var movie: MovieElement
    
    @StateObject var viewModel = MovieDetailsViewModel(imageUseCase: ImagesUseCase())
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    MovieDetailsHeaderView(movie: movie)
                    
                    Text("Cast")
                        .font(.system(size: 28, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                    
                    
                    ForEach(movie.cast, id: \.self) { actor in
                        Text(actor)
                            .font(.system(size: 20, weight: .medium))
                            .padding(.bottom, 1)
                            .frame(width: DEVICE_WIDHT / 1.5, height: 20, alignment: .leading)
                    }
                    
                    LazyVGrid(columns: [GridItem(.fixed(DEVICE_WIDHT / 2.4)), GridItem(.fixed(DEVICE_WIDHT / 2.4))]) {
                        
                        ForEach(viewModel.imageURLs, id: \.self) { url in
                            KFImage(url)
                                .resizable()
                                .scaledToFit()
                                .frame(width: DEVICE_WIDHT / 2.5)
                                .cornerRadius(10)
                        }
                        
                        if viewModel.canPagination {
                            HStack {
                                Text("loading...")
                                
                                ProgressView()
                                    .scaleEffect(1.3)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            }
                            .frame(width: DEVICE_WIDHT, height: 80)
                            .onAppear {
                                viewModel.getImages(pagination: true, tags: movie.title.lowercased())
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
            .padding()
            
            if viewModel.isLoading { LoadingView().padding(.top, DEVICE_HEIGHT / 2.5) }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                viewModel.getImages(pagination: false, tags: movie.title.lowercased())
            }
        }
        
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
        
        
        
        
        
        
        
    }
    
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: MovieElement(title: "Avenegers", year: 1, cast: ["Thor", "Ironman", "Blackwidow", "Hulk", "Captain America"], genres: [], rating: 2))
    }
}


struct MovieDetailsHeaderView: View {
    
    var movie: MovieElement
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text(movie.title)
                .font(.system(size: 32, weight: .black))
                .multilineTextAlignment(.leading)
            
            
            HStack {
                Text("\(movie.year.description)").font(.title3).foregroundColor(Color(.secondaryLabel))
                
                Rectangle().frame(width: 1, height: 15).foregroundColor(.gray)
                
                ForEach(movie.genres, id: \.self) { genre in
                    Text(genre).foregroundColor(.gray).padding(.trailing, -2)
                }
                
            }
            
            HStack {
                ForEach(1...5, id: \.self) { id in
                    Image(systemName: "star.fill").foregroundColor(movie.rating >= id ? .yellow : .gray)
                }
            }
        }
    }
}
