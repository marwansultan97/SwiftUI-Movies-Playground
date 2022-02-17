//
//  NetworkServiceTests.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 13/02/2022.
//

import XCTest
@testable import SWVL_Task
@testable import Alamofire

class NetworkServiceTests: XCTestCase {
    
    var config: URLSessionConfiguration!
    var mockSession: Session!
    var sut: NetworkService!

    override func setUpWithError() throws {
        config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = Session(configuration: config)
        sut = NetworkService(session: mockSession)
    }

    override func tearDownWithError() throws {
        config = nil
        mockSession = nil
        sut = nil
        MockURLProtocol.responseData = nil
        MockURLProtocol.error = nil
    }

    func testNetworkService_WhenSuccessfullResponseGiven_ShouldReturnTrue() {
        
        // Arrange
        let jsonString = "{\"stat\":\"ok\"}"
        MockURLProtocol.responseData = jsonString.data(using: .utf8)
        
        let expectation = expectation(description: "Should Return Successfull Api Call")
        
        // Act
        sut.request(model: MockResponseModel.self, apiAction: .photos(page: 0, tags: "")) { response in
            
            // Assert
            XCTAssertNil(response.failure)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
    
    
    func testNetworkService_WhenBadURLGiven_ShouldReturnTrue() {
        
        // Arrange
        let expectation = expectation(description: "Should Return unknown error")

        // Act
        
        sut.request(model: MockResponseModel.self, apiAction: .empty) { response in
            
            
            // Assert
            XCTAssertEqual(response.success, nil)
            XCTAssertEqual(response.failure, .unknown)
            
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkService_WhenDifferentJsonResponseRecieved_ShouldReturnTrue() {
        
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.responseData = jsonString.data(using: .utf8)
        
        let expectation = expectation(description: "Should Return Cannot Parse JSON error")
        
        // Act
        sut.request(model: MockResponseModel.self, apiAction: .photos(page: 0, tags: "")) { response in
            
            // Assert
            XCTAssertNil(response.success)
            XCTAssertEqual(response.failure, .cannotParseJson)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkService_WhenEmptyDataRecieved_ShouldReturnTrue() {
        
        // Arrange
        
        let expectation = expectation(description: "Empty Data Response Should Return Error")
        
        // Act
        sut.request(model: MockResponseModel.self, apiAction: .photos(page: 0, tags: "")) { response in

            // Assert
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
