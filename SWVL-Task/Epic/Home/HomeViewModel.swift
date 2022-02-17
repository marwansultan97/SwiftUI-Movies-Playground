//
//  HomeViewModel.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import SwiftUI


class HomeViewModel: ObservableObject {
    
    @Published var movies = [MovieElement]()
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var searchedMovies = [GroupedMovies]()
    
    private var filteredMoviesUseCase: FilteredMoviesProtocol
    private var moviesUseCase: MoviesUseCaseProtocol
    
    init(moviesUseCase: MoviesUseCaseProtocol = MoviesUseCase(),
         filteredMoviesUseCase: FilteredMoviesProtocol = FilteredMoviesUseCase()) {
        self.moviesUseCase = moviesUseCase
        self.filteredMoviesUseCase = filteredMoviesUseCase
    }
    
    func getMovies() {
        isLoading = true
        moviesUseCase.getMovies { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                self.alertItem = AlertItem(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK")), secondaryButton: nil)
            }
        }
    }
    
    func getFilteredMovies(query: String) {
        isLoading = true
        searchedMovies = filteredMoviesUseCase.filterMovies(movies: movies, query: query)
        isLoading = false
    }
    
}
