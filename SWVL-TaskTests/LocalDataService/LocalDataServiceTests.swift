//
//  LocalDataServiceTests.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 15/02/2022.
//

import XCTest
@testable import SWVL_Task

class LocalDataServiceTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
        
    }
    
    
    func testLocalDataService_WhenValidResponseRecieved_ShouldReturnTrue() {
        
        // Arrange
        let sut = LocalDataService()
        
        let expectation = expectation(description: "Should Return Success Model")
        
        // Act
        sut.fetchData(resource: .movies, responseModel: Movies.self) { response in
            
            
            // Assert
            switch response {
            case .success(let movies):
                XCTAssertGreaterThanOrEqual(movies.movies.count, 1)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        
    }
    
    
    func testLocalDataService_WhenInvalidResourceGiven_ShouldReturnTrue() {
        
        // Arrange
        let sut = LocalDataService()
        
        let expectation = expectation(description: "Should Return Invalid Resource Error")
        
        // Act
        sut.fetchData(resource: .mock, responseModel: Movies.self) { response in
            
            
            // Assert
            switch response {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .pathError)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        
    }
    
    func testLocalDataService_WhenInvalidJSONRecieved_ShouldReturnTrue() {
        
        // Arrange
        let sut = LocalDataService()
        
        let expectation = expectation(description: "Should Return Invalid Data Error")
        
        // Act
        sut.fetchData(resource: .movies, responseModel: MockResponseModel.self) { response in
            
            
            // Assert
            switch response {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .invalidData)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        
    }





}
