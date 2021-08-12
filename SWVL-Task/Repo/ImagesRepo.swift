//
//  ImagesRepo.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 11/08/2021.
//

import Foundation

protocol ImagesRepo {
    func getImages(page: Int, tags: String, completionHandler: @escaping(Result<Images, NetworkError>) -> Void)
}


class ImagesRepoImpl: ImagesRepo {
    
    
    func getImages(page: Int, tags: String, completionHandler: @escaping (Result<Images, NetworkError>) -> Void) {
        AFRequest.request(model: Images.self, request: .photos(page: page, tags: tags)) { response in
            switch response {
            case .success(let images):
                completionHandler(.success(images))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
    
    
    
}
