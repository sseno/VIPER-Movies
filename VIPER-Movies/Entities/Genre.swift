//
//  Genre.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import Foundation

struct GenreList: Decodable {
    
    let genres: [Genre]?
}

struct Genre: Decodable {
    
    let id: Int?
    let name: String?
}
