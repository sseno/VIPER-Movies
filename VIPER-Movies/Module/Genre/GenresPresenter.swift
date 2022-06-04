//
//  GenresPresenter.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class GenresPresenter: ViewToPresenterGenresProtocol {
    
    // MARK: - Properties
    weak var view: PresenterToViewGenresProtocol?
    var interactor: PresenterToInteractorGenresProtocol?
    var router: PresenterToRouterGenresProtocol?
    
    var genreList: GenreList?
    
    // MARK: - Inputs from view
    func viewDidLoad() {
        view?.showLoading()
        interactor?.loadGenres()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let genres = genreList?.genres else {
            return 0
        }
        return genres.count
    }
    
    func setTextNode(by indexPath: IndexPath) -> String? {
        guard let genres = genreList?.genres else {
            return nil
        }
        return genres[indexPath.row].name
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveGenre(at: index)
    }
    
    func deselectRowAt(indexPath: IndexPath) {
        view?.deselectRowAt(indexPath: indexPath)
    }
    
}

// MARK: - InteractorToProtocolGenresProtocol
extension GenresPresenter: InteractorToPresenterGenresProtocol {
    
    func fetchGenresSuccess(genreList: GenreList) {
        self.genreList = genreList
        view?.hideLoading()
        view?.onFetchGenresSuccess()
    }
    
    func fetchGenresFailure(errorCode: Int) {
        view?.hideLoading()
        view?.onFetchGenresFailure(error: "fetch genres error: \(errorCode)")
    }
    
    func getGenreSuccess(genre: Genre) {
        router?.pushToMovieListByGenre(on: view!, with: genre)
    }
    
    func getGenreFailure() {
        view?.hideLoading()
        print("error retrieve genre by index")
    }
}
