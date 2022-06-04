//
//  MovieDetailPresenter.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import Foundation

class MovieDetailPresenter: ViewToPresenterMovieDetailProtocol {
    
    enum TableSection: Int, CaseIterable {
        case details, reviews
    }
    
    var view: PresenterToViewMovieDetailProtocol?
    
    var interactor: PresenterToInteractorMovieDetailProtocol?
    
    var router: PresenterToRouterMovieDetailProtocol?
    
    var movieDetail: MovieDetail?
    var userReview: UserReview?
    
    private let movieResult: MovieResult
    
    init(movieResult: MovieResult) {
        self.movieResult = movieResult
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.loadMovieDetail(with: movieResult.id)
        interactor?.loadMoviewDetailReview(with: movieResult.id)
    }
    
    func numberOfSections() -> Int {
        return TableSection.allCases.count
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func numberOfReviewInSection() -> Int {
        return userReview?.results?.count ?? 0
    }

}

// MARK: - InteractorToPresenterMovieDetailProtocol
extension MovieDetailPresenter: InteractorToPresenterMovieDetailProtocol {
    
    func fetchMovieDetailSuccess(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        view?.hideLoading()
        view?.onFetchMovieDetailSuccess()
    }
    
    func fetchMovieDetailFailure(errorCode: Int) {
        view?.hideLoading()
        view?.onFetchMovieDetailFailure(error: "error fetching movie detail with error: \(errorCode)")
    }
    
    func fetchUserReviewSuccess(userReview: UserReview) {
        self.userReview = userReview
        view?.hideLoading()
        view?.onFetchUserReviewSuccess()
    }
    
    func fetchUserReviewFailure(errorCode: Int) {
        view?.hideLoading()
        view?.onFetchUserReviewFailure(error: "error fetching user review with error: \(errorCode)")
    }
    
    func getMovieDetailSuccess(moveDetail: MovieDetail) {
        //
    }
    
    func getMovieDetailFailure() {
        view?.hideLoading()
        print("error retrieve moviedetail")
    }
}
