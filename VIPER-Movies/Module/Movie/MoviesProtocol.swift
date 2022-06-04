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
    
    func deselectRowAt(indexPath: IndexPath)
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMoviesProtocol: AnyObject {
    
    var view: PresenterToViewMoviesProtocol? { get set }
    var interactor: PresenterToInteractorMoviesProtocol? { get set }
    var router: PresenterToRouterMoviesProtocol? { get set }
    
    var movieResuls: [MovieResult] { get set }
    
    func viewDidLoad()
    func setNavigationBarTitle() -> String
    
    func numberOfRowsInSection() -> Int
    func setImageUrl(by indexPath: IndexPath) -> String?
    func setTextTitle(by indexPath: IndexPath) -> String?
    func setTextOverview(by indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(indexPath: IndexPath)
    
    func pullToRefresh()
    func didEndScrolling()
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMoviesProtocol: AnyObject {
    
    var presenter: InteractorToPresenterMoviesProtocol? { get set }
    
    func loadMovies(page: Int, with genreId: Int?)
    func retrieveMovie(at index: Int)
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMoviesProtocol: AnyObject {
    
    func fetchMoviesSuccess(movieResults: [MovieResult])
    func fetchMoviesFailure(errorCode: Int)
    
    func getMovieSuccess(movie: MovieResult)
    func getMovieFailure()
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMoviesProtocol: AnyObject {
    
    static func createModule(with genre: Genre) -> UIViewController
    func pushToMovieDetailById(on view: PresenterToViewMoviesProtocol, with movie: MovieResult)
}
