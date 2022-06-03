//
//  Movie.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class MovieService: APIManager {
    
    func requestMovieList(page: Int, by genreId: Int, completion: @escaping (Result<Movie, ErrorAPI>) -> Void) {
        self.request(httpMethod: .get, pathUrl: "discover/movie", lastPathUrl: "page=\(page)&with_genres=\(genreId)", completion: completion
        )
    }
}
