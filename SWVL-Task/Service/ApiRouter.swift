//
//  ApiRouter.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation
import Alamofire

enum ApiRequest: URLRequestConvertible {
    
    enum Constants {
        static let baseURL = "https://www.flickr.com/services/rest/"
    }
        
    case photos(page: Int, tags: String)
    
    var url: URL {
        switch self {
        case .photos:
            return URL(string: Constants.baseURL)!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .photos:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .photos(let page, let tags):
            return ["method": "flickr.photos.search",
                    "api_key": API_KEY,
                    "page": page,
                    "per_page": 10,
                    "format": "json",
                    "text": tags,
                    "nojsoncallback": 1
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return [:]
        }
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.method = self.method
        urlRequest.headers = self.headers
        
        switch method {
        case .get, .delete:
            return try URLEncoding.default.encode(urlRequest, with: self.parameters)
        default:
            return try JSONEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}
