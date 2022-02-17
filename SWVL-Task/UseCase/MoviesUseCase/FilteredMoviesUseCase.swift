//
//  FilteredMoviesUseCase.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import Foundation


protocol FilteredMoviesProtocol {
        
    func filterMovies(movies: [MovieElement], query: String) -> [GroupedMovies]
    
}

class FilteredMoviesUseCase: FilteredMoviesProtocol {
    
    
    func filterMovies(movies: [MovieElement], query: String) -> [GroupedMovies] {
        var result = [GroupedMovies]()
        
        let dictionary = searchAndGroupByYear(movies: movies, query: query)
        
        result = sortFirstFiveMovies(dict: dictionary)
        
        return result
    }
    
    func searchAndGroupByYear(movies: [MovieElement], query: String) -> Dictionary<Int, [MovieElement]> {
        var dictionary = Dictionary<Int, [MovieElement]>()
        
        let searchedArray = movies.filter { $0.title.lowercased().contains(query) }
        dictionary = Dictionary(grouping: searchedArray, by: \.year)
        
        return dictionary
    }
    
    
    
    func sortFirstFiveMovies(dict: Dictionary<Int, [MovieElement]>) -> [GroupedMovies] {
        
        var finalResult = [GroupedMovies]()
        
        finalResult = dict.map { (key: Int, value: [MovieElement]) -> GroupedMovies in
            let sortedValueByRating = value.sorted { $0.rating > $1.rating }
            let firstFiveValues = Array(sortedValueByRating.prefix(5))
            return GroupedMovies(year: key, movies: firstFiveValues)
        }
        
        finalResult = finalResult.sorted { $0.year < $1.year }
        
        return finalResult
    }
    
    
    
}
