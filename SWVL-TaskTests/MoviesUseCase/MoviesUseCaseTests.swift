//
//  MoviesUseCaseTests.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 15/02/2022.
//

import XCTest
@testable import SWVL_Task

class MoviesUseCaseTests: XCTestCase {

    
    var mockMoviesLocalData: MockMoviesLocalData!
    var sut: MoviesUseCase!
    
    override func setUpWithError() throws {
        mockMoviesLocalData = MockMoviesLocalData()
        mockMoviesLocalData.error = nil
        sut = MoviesUseCase(client: mockMoviesLocalData)
    }

    override func tearDownWithError() throws {
        mockMoviesLocalData = nil
        sut = nil
    }
    
    func testMoviesUseCaseTests_WhenGetMoviesCalled_ShouldReturnTrue() {
        
        
        // Arrange
        let mockMoviesLocalData = MockMoviesLocalData()
        mockMoviesLocalData.error = nil
        let sut = MoviesUseCase(client: mockMoviesLocalData)
        
        let expectation = expectation(description: "Should Return Movies")
        
        // Act
        sut.getMovies { response in
            
            // Assert
            switch response {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertGreaterThanOrEqual(movies.count, 1)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
    
    func testMoviesUseCaseTests_WhenGetMoviesCalled_ShouldReturnError() {
        
        
        // Arrange
        let mockMoviesLocalData = MockMoviesLocalData()
        mockMoviesLocalData.error = .invalidData
        let sut = MoviesUseCase(client: mockMoviesLocalData)
        
        let expectation = expectation(description: "Should Return Error")
        
        // Act
        sut.getMovies { response in
            
            // Assert
            switch response {
            case .success(_):
                XCTFail()
            case .failure(let err):
                XCTAssertNotNil(err)
                XCTAssertEqual(err, .invalidData)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }

}
