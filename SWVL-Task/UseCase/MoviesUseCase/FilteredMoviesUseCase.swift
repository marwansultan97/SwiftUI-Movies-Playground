//
//  FilteredMoviesUseCase.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import Foundation


protocol FilteredMovies {
        
    func filterMovies(query: String, completionHandler: @escaping(Result<[GroupedMovies], DatabaseError>) -> Void)
    
}

class FilteredMoviesUseCase: FilteredMovies {
    
    private var repo = MoviesRepoImpl()
    
    func filterMovies(query: String, completionHandler: @escaping (Result<[GroupedMovies], DatabaseError>) -> Void) {
        
        repo.getMovies { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let movies):
                completionHandler(.success(self.filterProcess(query: query, movies: movies.movies)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }
    
    
    private func filterProcess(query: String, movies: [MovieElement]) -> [GroupedMovies]  {
        let searchedArray = movies.filter { $0.title.lowercased().contains(query) }
        let searchedGroupedByYear = Dictionary(grouping: searchedArray, by: \.year)
        
        let newMoviesStruct = searchedGroupedByYear.map { (key: Int, value: [MovieElement]) -> GroupedMovies in
            let sortedValueByRating = value.sorted { $0.rating > $1.rating }
            let firstFiveValues = Array(sortedValueByRating.prefix(5))
            return GroupedMovies(year: key, movies: firstFiveValues)
        }
        
        let sortNewMoviesStruct = newMoviesStruct.sorted { $0.year < $1.year }
        
        
        return sortNewMoviesStruct
    }
    
    
    
}
