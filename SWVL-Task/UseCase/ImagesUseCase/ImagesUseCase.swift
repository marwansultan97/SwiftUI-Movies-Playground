//
//  ImagesUseCase.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//

import Foundation


protocol ImagesUseCaseProtocol {
    // Boolean Value for pagination (is Last Page)
    func getImages(page: Int, tags: String, completion: @escaping(Result<([URL], Bool), NetworkError>) -> Void)
}

class ImagesUseCase: ImagesUseCaseProtocol {
    
    private var service: NetworkClient
    
    init(service: NetworkClient = NetworkService()) {
        self.service = service
    }
    
    func getImages(page: Int, tags: String, completion: @escaping (Result<([URL], Bool), NetworkError>) -> Void) {
        
        service.request(model: Images.self, apiAction: .photos(page: page, tags: tags)) { response in
            switch response {
            case .success(let images):
                images.photos.page < images.photos.pages ? completion(.success((self.convertToUrl(images: images.photos.photo), false))) : completion(.success((self.convertToUrl(images: images.photos.photo), true)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
    private func convertToUrl(images: [Photo]) -> [URL] {
        let arrayOfURLs = images.map { photo -> URL in
            if let url = URL(string: "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg") {
                return url
            } else {
                return URL(string: "www.google.com")!
            }
        }
        return arrayOfURLs
    }
    
    
}
