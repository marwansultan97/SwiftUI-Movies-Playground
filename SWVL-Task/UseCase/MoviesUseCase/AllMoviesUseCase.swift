//
//  AllMoviesUseCase.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation

typealias allMoviesResult = (Result<[MovieElement], DatabaseError>) -> Void

protocol AllMovies {
    
    func getMovies(completionHandler: @escaping (Result<[MovieElement], DatabaseError>) -> Void)
        
}

class AllMoviesUseCase: AllMovies {
    
    private var repo = MoviesRepoImpl()
    
    func getMovies(completionHandler: @escaping (Result<[MovieElement], DatabaseError>) -> Void) {
        repo.getMovies { response in
            switch response {
            case .success(let movies):
                completionHandler(.success(movies.movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    
    
}
