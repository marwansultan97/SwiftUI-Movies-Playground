//
//  MovieDetailsViewModel.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//

import SwiftUI


class MovieDetailsViewModel: ObservableObject {
    
    
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var imageURLs = [URL]()
    @Published var isLastItem = false
    @Published var canPagination = false
    
    var page = 1
    
    var imageUseCase: ImagesUseCaseProtocol
    
    init(imageUseCase: ImagesUseCaseProtocol = ImagesUseCase()) {
        self.imageUseCase = imageUseCase
    }
    
    
    func getImages(pagination: Bool, tags: String) {
        
        if pagination {
            page += 1
        } else {
            isLoading = true
        }
        
        imageUseCase.getImages(page: page, tags: tags) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success((let imageURLs, let isLastPage)):
                self.imageURLs.append(contentsOf: imageURLs)
                self.canPagination = !isLastPage
                print(self.page)
            case .failure(let error):
                self.alertItem = AlertItem(message: Text(error.errorDescription), dismissButton: .default(Text("OK")), secondaryButton: nil)
            }
        }
    }
    
}
