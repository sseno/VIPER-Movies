//
//  GenreProtocol.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import UIKit

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewGenresProtocol: AnyObject {
    
    func onFetchGenresSuccess()
    func onFetchGenresFailure(error: String)
    
    func showLoadingHUD()
    func hideLoadingHUD()
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterGenresProtocol: AnyObject {
    
    var view: PresenterToViewGenresProtocol? { get set }
    
    var genres: Genres? { get set }
    
//    func viewDidLoad()
    
    func numberOfRowsInSection() -> Int
    func setTextNode(by indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorGenresProtocol: AnyObject {
    
    var presenter: InteractorToProtocolGenresProtocol? { get set }
    
    func loadGenres()
//    func retrieveGenres(at index: Int)
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToProtocolGenresProtocol: AnyObject {
    
    func fetchGenresSuccess(genres: [Genres])
    func fetchGenresFailure(errorCode: Int)
    
    func getGenreSuccess(gender: Genre)
    func getGenreFailure()
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterGenresProtocol: AnyObject {
    
    static func createModule() -> UINavigationController
    func pushToMovieDetail(on view: PresenterToViewGenresProtocol, with genre: Genre)
}
