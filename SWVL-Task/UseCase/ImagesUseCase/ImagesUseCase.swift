//
//  ImagesUseCase.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//

import Foundation


protocol AllImages {
    // Boolean Value for pagination (is Last Page)
    func getImages(page: Int, tags: String, completion: @escaping(Result<([URL], Bool), NetworkError>) -> Void)
}

class ImagesUseCase: AllImages {
    
    var repo = ImagesRepoImpl()
    
    
    func getImages(page: Int, tags: String, completion: @escaping (Result<([URL], Bool), NetworkError>) -> Void) {
        
        repo.getImages(page: page, tags: tags) { [weak self] response in
            guard let self = self else { return }
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
