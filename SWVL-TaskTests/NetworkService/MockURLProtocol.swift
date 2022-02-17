//
//  MockURLProtocol.swift
//  SWVL-TaskTests
//
//  Created by Marwan-Youxel on 13/02/2022.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    
    static var responseData: Data?
    static var error: Error?
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocol(self, didLoad: MockURLProtocol.responseData ?? Data())
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    
    override func stopLoading() { }
}
