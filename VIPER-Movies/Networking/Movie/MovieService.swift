//
//  Movie.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class MovieService: APIManager {
    
    func requestMovieList(page: Int, by genreId: Int, completion: @escaping (Result<Movie, ErrorAPI>) -> Void) {
        self.request(httpMethod: .get, pathUrl: "discover/movie", lastPathUrl: "page=\(page)&with_genres=\(genreId)", completion: completion)
    }
    
    func requestMovieDetail(by movieId: Int, completion: @escaping (Result<MovieDetail, ErrorAPI>) -> Void) {
        self.request(httpMethod: .get, pathUrl: "movie/\(movieId)", completion: completion)
    }
    
    func requestMovieDetailReviews(by movieId: Int, completion: @escaping (Result<UserReview, ErrorAPI>) -> Void) {
        self.request(httpMethod: .get, pathUrl: "movie/\(movieId)/reviews", completion: completion)
    }
}
