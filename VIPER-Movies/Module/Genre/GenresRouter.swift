//
//  GenresRouter.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation
import UIKit

class GenresRouter: PresenterToRouterGenresProtocol {
    
    static func createModule() -> UINavigationController {
        let genreListViewController = GenreListViewController()
        let navigationController = UINavigationController(rootViewController: genreListViewController)
        
        let presenter: ViewToPresenterGenresProtocol & InteractorToPresenterGenresProtocol = GenresPresenter()
        genreListViewController.presenter = presenter
        genreListViewController.presenter?.router = GenresRouter()
        genreListViewController.presenter?.view = genreListViewController
        genreListViewController.presenter?.interactor = GenresInteractor(servcie: GenreService())
        genreListViewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    func pushToMovieListByGenre(on view: PresenterToViewGenresProtocol, with genre: Genre) {
        let movieListViewController = MoviesRouter.createModule(with: genre)
        
        let viewController = view as! GenreListViewController
        viewController.navigationController?.pushViewController(movieListViewController, animated: true)
    }
}
