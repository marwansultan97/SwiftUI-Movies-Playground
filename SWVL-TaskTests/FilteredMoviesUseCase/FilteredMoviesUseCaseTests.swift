//
//  FilteredMoviesUseCaseTests.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 16/02/2022.
//

import XCTest
@testable import SWVL_Task

class FilteredMoviesUseCaseTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testFilteredMoviesUseCase_WhenFilterMoviesCalled_ShouldReturnTrue() throws {
        
        // Arrange
        let sut = FilteredMoviesUseCase()
        let movies: [MovieElement] = [
            .init(title: "aaa", year: 2021, cast: [], genres: [], rating: 3),
            .init(title: "aaa", year: 2022, cast: [], genres: [], rating: 3),
            .init(title: "bbb", year: 2020, cast: [], genres: [], rating: 5),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 5),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 4),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 3),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 2),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 1),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 1),
            .init(title: "aaa", year: 2020, cast: [], genres: [], rating: 1),
            .init(title: "ccc", year: 2020, cast: [], genres: [], rating: 5),
            .init(title: "ddd", year: 2020, cast: [], genres: [], rating: 5),
            .init(title: "eee", year: 2020, cast: [], genres: [], rating: 5),
            .init(title: "ssss", year: 2020, cast: [], genres: [], rating: 5),
        ]
        
        // Act
        let filteredMovieGroups = sut.filterMovies(movies: movies, query: "a")
        
        let firstGroup = try XCTUnwrap(filteredMovieGroups.first)
        
        // Assert
        XCTAssertEqual(filteredMovieGroups.count, 3)
        XCTAssertLessThanOrEqual(filteredMovieGroups[0].year, filteredMovieGroups[1].year)
        XCTAssertLessThanOrEqual(firstGroup.movies.count, 5)
        XCTAssertGreaterThanOrEqual(firstGroup.movies[0].rating, firstGroup.movies[1].rating)

    }

}
