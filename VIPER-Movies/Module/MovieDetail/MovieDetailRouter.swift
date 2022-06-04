//
//  MovieDetailRouter.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import UIKit

class MovieDetailRouter: PresenterToRouterMovieDetailProtocol {
    
    static func createModule(with movieResult: MovieResult) -> UIViewController {
        let movieDetailViewController = MovieDetailViewController()
//        let navigationController = UINavigationController(rootViewController: movieListViewController)

        let presenter: ViewToPresenterMovieDetailProtocol & InteractorToPresenterMovieDetailProtocol = MovieDetailPresenter(movieResult: movieResult)

        movieDetailViewController.presenter = presenter
        movieDetailViewController.presenter?.router = MovieDetailRouter()
        movieDetailViewController.presenter?.view = movieDetailViewController
        movieDetailViewController.presenter?.interactor = MovieDetailInteractor(service: MovieService())
        movieDetailViewController.presenter?.interactor?.presenter = presenter
        
        return movieDetailViewController
    }
    
    func pushToMovieDetailById(on view: PresenterToViewMovieDetailProtocol, with movie: MovieResult) {
        //
    }
}
