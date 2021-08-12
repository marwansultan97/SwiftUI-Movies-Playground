//
//  Movie.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 10/08/2021.
//

import Foundation

struct Movies: Codable {
    let movies: [MovieElement]
}

struct MovieElement: Codable {
    let title: String
    let year: Int
    let cast: [String]
    let genres: [String]
    let rating: Int
    
}

extension MovieElement: Identifiable {
    var id: String {
        return self.title
    }
}



struct GroupedMovies {
    let year: Int
    let movies: [MovieElement]
}

extension GroupedMovies: Identifiable {
    var id: Int {
        return self.year
    }
}
