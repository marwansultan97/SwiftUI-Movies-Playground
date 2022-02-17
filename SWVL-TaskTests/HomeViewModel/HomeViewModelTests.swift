//
//  HomeViewModelTests.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 16/02/2022.
//

import XCTest
@testable import SWVL_Task

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var filteredMoviesUseCase: FilteredMoviesUseCase!
    var mockMoviesLocalDataClient: MockMoviesLocalData!
    var moviesUseCase: MoviesUseCase!

    
    override func setUpWithError() throws {
        
        filteredMoviesUseCase = FilteredMoviesUseCase()
        mockMoviesLocalDataClient = MockMoviesLocalData()
        moviesUseCase = MoviesUseCase(client: mockMoviesLocalDataClient)
        sut = .init(moviesUseCase: moviesUseCase, filteredMoviesUseCase: filteredMoviesUseCase)
    }

    override func tearDownWithError() throws {
        filteredMoviesUseCase = nil
        mockMoviesLocalDataClient = nil
        moviesUseCase = nil
        sut = nil
    }
    
    
    func test_HomeViewModel_WhenGetMoviesCalled_MoviesShouldNotBeEmpty() {
        // Arrange
        mockMoviesLocalDataClient.error = nil
        
        // Act
        sut.getMovies()
        
        // Assert
        XCTAssertFalse(sut.movies.isEmpty)
        XCTAssertNil(sut.alertItem)
    }
    
    func test_HomeViewModel_WhenGetMoviesCalled_ShouldReturnError() {
        // Arrange
        mockMoviesLocalDataClient.error = .invalidData
        
        // Act
        sut.getMovies()
        
        // Assert
        XCTAssertTrue(sut.movies.isEmpty)
        XCTAssertNotNil(sut.alertItem)
    }
    
    func test_HomeViewModel_WhenGetFilteredMoviesCalled_FilteredMoviesShouldNotBeEmpty() {
        // Arrange
        mockMoviesLocalDataClient.error = nil
        // Act
        sut.getMovies()
        sut.getFilteredMovies(query: "1")
        
        // Assert
        XCTAssertFalse(sut.searchedMovies.isEmpty)
    }
    
    
    


}
