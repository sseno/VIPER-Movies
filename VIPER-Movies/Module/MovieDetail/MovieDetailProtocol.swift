//
//  MovieDetailProtocol.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import UIKit

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewMovieDetailProtocol: AnyObject {
    
    func onFetchMovieDetailSuccess()
    func onFetchMovieDetailFailure(error: String)
    
    func onFetchVideoTrailerSuccess()
    func onFetchVideoTrailerFailure(error: String)
    
    func onFetchUserReviewSuccess()
    func onFetchUserReviewFailure(error: String)
    
    func showLoading()
    func hideLoading()
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMovieDetailProtocol: AnyObject {
    
    var view: PresenterToViewMovieDetailProtocol? { get set }
    var interactor: PresenterToInteractorMovieDetailProtocol? { get set }
    var router: PresenterToRouterMovieDetailProtocol? { get set }
    
    var movieDetail: MovieDetail? { get set }
    var videoTrailer: VideoTrailer? { get set }
    var userReview: UserReview? { get set }
    
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func numberOfReviewInSection() -> Int
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMovieDetailProtocol: AnyObject {
    
    var presenter: InteractorToPresenterMovieDetailProtocol? { get set }
    
    func loadMovieDetail(with movieId: Int?)
    func loadMovideVideoTrailer(with movideId: Int?)
    func loadMoviewDetailReview(with movieId: Int?)
    func retrieveMovie(at index: Int)
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMovieDetailProtocol: AnyObject {
    
    func fetchMovieDetailSuccess(movieDetail: MovieDetail)
    func fetchMovieDetailFailure(errorCode: Int)
    
    func fetchVideoTrailerSuccess(videoTrailer: VideoTrailer)
    func fetchVideoTrailerFailure(errorCode: Int)
    
    func fetchUserReviewSuccess(userReview: UserReview)
    func fetchUserReviewFailure(errorCode: Int)
    
    func getMovieDetailSuccess(moveDetail: MovieDetail)
    func getMovieDetailFailure()
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMovieDetailProtocol: AnyObject {
    
    static func createModule(with movieResult: MovieResult) -> UIViewController
    func pushToMovieDetailById(on view: PresenterToViewMovieDetailProtocol, with movie: MovieResult)
}
