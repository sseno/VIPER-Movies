//
//  MovieDetailInteractor.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import Foundation

class MovieDetailInteractor: PresenterToInteractorMovieDetailProtocol {
    
    var presenter: InteractorToPresenterMovieDetailProtocol?
    
    var movieDetail: MovieDetail?
    var userReview: UserReview?
    
    private let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
    
    func loadMovieDetail(with movieId: Int?) {
        guard let movieId = movieId else {
            return
        }

        service.requestMovieDetail(by: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.movieDetail = response
                    self.presenter?.fetchMovieDetailSuccess(movieDetail: response)
                }
            case .failure(let error):
                switch error {
                case .serverError(statusCode: let code):
                    self.presenter?.fetchMovieDetailFailure(errorCode: code)
                default:
                    break
                }
            }
        }
    }
    
    func loadMoviewDetailReview(with movieId: Int?) {
        guard let movieId = movieId else {
            return
        }
        
        service.requestMovieDetailReviews(by: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.userReview = response
                    self.presenter?.fetchUserReviewSuccess(userReview: response)
                }
            case .failure(let error):
                switch error {
                case .serverError(statusCode: let code):
                    self.presenter?.fetchUserReviewFailure(errorCode: code)
                default:
                    break
                }
            }
        }
    }
    
    func retrieveMovie(at index: Int) {
        //
    }
}
