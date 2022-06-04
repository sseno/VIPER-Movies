//
//  Genre.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import Foundation

struct GenreList: Codable {
    
    let genres: [Genre]?
}

struct Genre: Codable {
    
    let id: Int?
    let name: String?
}
