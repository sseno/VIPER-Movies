//
//  MoviesProtocol.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import UIKit

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewMoviesProtocol: AnyObject {
    
    func onFetchMoviesSuccess()
    func onFetchMoviesFailure(error: String)
    
    func showLoading()
    func hideLoading()
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMoviesProtocol: AnyObject {
    
    var view: PresenterToViewMoviesProtocol? { get set }
    var interactor: PresenterToInteractorMoviesProtocol? { get set }
    var router: PresenterToRouterMoviesProtocol? { get set }
    
    var movies: Movie? { get set }
    
    func viewDidLoad()
    func setNavigationBarTitle() -> String
    
    func numberOfRowsInSection() -> Int
    func setImageUrl(by indexPath: IndexPath) -> String?
    func setTextTitle(by indexPath: IndexPath) -> String?
    func setTextOverview(by indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMoviesProtocol: AnyObject {
    
    var presenter: InteractorToPresenterMoviesProtocol? { get set }
    
    func loadMovies(with genreId: Int?)
    func retrieveMovie(at index: Int)
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMoviesProtocol: AnyObject {
    
    func fetchMoviesSuccess(movies: Movie)
    func fetchMoviesFailure(errorCode: Int)
    
    func getMovieSuccess(movie: MovieResult)
    func getMovieFailure()
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMoviesProtocol: AnyObject {
    
    static func createModule(with genre: Genre) -> UIViewController
    func pushToMovieDetailById(on view: PresenterToViewMoviesProtocol, with movie: MovieResult)
}
