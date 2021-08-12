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
    
    var filteredMoviesUseCase: FilteredMovies
    var allMoviesUseCase: AllMovies
    
    init(allMoviesUseCase: AllMovies, filteredMoviesUseCase: FilteredMovies) {
        self.allMoviesUseCase = allMoviesUseCase
        self.filteredMoviesUseCase = filteredMoviesUseCase
    }
    
    func getMovies() {
        isLoading = true
        allMoviesUseCase.getMovies { [weak self] response in
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
        filteredMoviesUseCase.filterMovies(query: query) { [weak self] response in
            self?.isLoading = false
            switch response {
            case .success(let movies):
                    self?.searchedMovies = movies
            case .failure(let error):
                self?.alertItem = AlertItem(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK")), secondaryButton: nil)
            }
        }
    }
    
}
