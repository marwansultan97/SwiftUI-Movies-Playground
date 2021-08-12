//
//  MoviesRepo.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import Foundation


protocol MoviesRepo {
    func getMovies(completionHandler: @escaping(Result<Movies, DatabaseError>) -> Void)
}

class MoviesRepoImpl: MoviesRepo {
    func getMovies(completionHandler: @escaping (Result<Movies, DatabaseError>) -> Void) {
        LocalDataFetcher.fetchData(resource: .movies, responseModel: Movies.self) { response in
            switch response {
            case .success(let movies):
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
}
