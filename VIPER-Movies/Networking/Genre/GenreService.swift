//
//  GenreService.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class GenreService: APIManager {
    
    func requestGenreList(completion: @escaping (Result<GenreList, ErrorAPI>) -> Void) {
        self.request(httpMethod: .get, pathUrl: "genre/movie/list", completion: completion)
    }
}
