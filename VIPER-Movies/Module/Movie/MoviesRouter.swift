//
//  MoviesRouter.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import UIKit

class MoviesRouter: PresenterToRouterMoviesProtocol {
    
    static func createModule(with genre: Genre) -> UIViewController {
        let movieListViewController = MoviewListViewController()
//        let navigationController = UINavigationController(rootViewController: movieListViewController)

        let presenter: ViewToPresenterMoviesProtocol & InteractorToPresenterMoviesProtocol = MoviesPresenter(genre: genre)
        
        movieListViewController.presenter = presenter
        movieListViewController.presenter?.router = MoviesRouter()
        movieListViewController.presenter?.view = movieListViewController
        movieListViewController.presenter?.interactor = MovieInteractor(service: MovieService())
        movieListViewController.presenter?.interactor?.presenter = presenter
        
        return movieListViewController
    }
    
    func pushToMovieDetailById(on view: PresenterToViewMoviesProtocol, with movie: MovieResult) {
        let movieDetailViewController = MovieDetailRouter.createModule(with: movie)
        
        let viewController = view as! MoviewListViewController
        viewController.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}
