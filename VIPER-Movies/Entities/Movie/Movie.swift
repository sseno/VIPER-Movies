//
//  Movie.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

struct Movie: Codable {
    
    let page: Int?
    let results: [MovieResult]?
    let totalPages: Int?
    
    enum CondingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct MovieResult: Codable {
    
    let id: Int?
    let title: String?
    let posterPath: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case overview
    }
}
