//
//  MoviesUseCase.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation


protocol MoviesUseCaseProtocol {
    
    func getMovies(completionHandler: @escaping (Result<[MovieElement], DatabaseError>) -> Void)
        
}

class MoviesUseCase: MoviesUseCaseProtocol {
    
    private var client: LocalDataClient
    
    init(client: LocalDataClient = LocalDataService()) {
        self.client = client
    }
    
    func getMovies(completionHandler: @escaping (Result<[MovieElement], DatabaseError>) -> Void) {

        client.fetchData(resource: .movies, responseModel: Movies.self) { response in
            switch response {
            case .success(let movies):
                completionHandler(.success(movies.movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }

    
    
}
