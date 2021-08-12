//
//  Images.swift
//  SWVL-Task
//
//  Created by Marwan Osama on 12/08/2021.
//

import Foundation

// MARK: - Movies
struct Images: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
