//
//  GenresProtocol.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import UIKit

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewGenresProtocol: AnyObject {
    
    func onFetchGenresSuccess()
    func onFetchGenresFailure(error: String)
    
    func showLoading()
    func hideLoading()
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterGenresProtocol: AnyObject {
    
    var view: PresenterToViewGenresProtocol? { get set }
    var interactor: PresenterToInteractorGenresProtocol? { get set }
    var router: PresenterToRouterGenresProtocol? { get set }
    
    var genreList: GenreList? { get set }
    
    func viewDidLoad()
    
    func numberOfRowsInSection() -> Int
    func setTextNode(by indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorGenresProtocol: AnyObject {
    
    var presenter: InteractorToPresenterGenresProtocol? { get set }
    
    func loadGenres()
    func retrieveGenre(at index: Int)
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterGenresProtocol: AnyObject {
    
    func fetchGenresSuccess(genreList: GenreList)
    func fetchGenresFailure(errorCode: Int)
    
    func getGenreSuccess(genre: Genre)
    func getGenreFailure()
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterGenresProtocol: AnyObject {
    
    static func createModule() -> UINavigationController
    func pushToMovieListByGenre(on view: PresenterToViewGenresProtocol, with genre: Genre)
}
