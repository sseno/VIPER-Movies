//
//  MoviesPresenter.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class MoviesPresenter: ViewToPresenterMoviesProtocol {
    
    var view: PresenterToViewMoviesProtocol?
    
    var interactor: PresenterToInteractorMoviesProtocol?
    
    var router: PresenterToRouterMoviesProtocol?
    
    var movieResuls: [MovieResult] = []
    private var page = 1
    
    private let genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.loadMovies(page: 1, with: genre.id)
    }
    
    func setNavigationBarTitle() -> String {
        return genre.name ?? "Movies"
    }
    
    func numberOfRowsInSection() -> Int {
        return movieResuls.count
    }
    
    func setImageUrl(by indexPath: IndexPath) -> String? {
        guard movieResuls.count > 0, let path = movieResuls[indexPath.row].posterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w500/" + path
    }
    
    func setTextTitle(by indexPath: IndexPath) -> String? {
        guard movieResuls.count > 0 else {
            return nil
        }
        return movieResuls[indexPath.row].title
    }
    
    func setTextOverview(by indexPath: IndexPath) -> String? {
        guard movieResuls.count > 0 else {
            return nil
        }
        return movieResuls[indexPath.row].overview
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveMovie(at: index)
    }
    
    func deselectRowAt(indexPath: IndexPath) {
        view?.deselectRowAt(indexPath: indexPath)
    }
    
    func pullToRefresh() {
        interactor?.loadMovies(page: 1, with: genre.id)
    }
    
    func didEndScrolling() {
        view?.showLoading()
        page += 1
        interactor?.loadMovies(page: page, with: genre.id)
    }
}

// MARK: - InteractorToPresenterMoviesProtocol
extension MoviesPresenter: InteractorToPresenterMoviesProtocol {
    
    func fetchMoviesSuccess(movieResults: [MovieResult]) {
        self.movieResuls = movieResults
        view?.hideLoading()
        view?.onFetchMoviesSuccess()
    }
    
    func fetchMoviesFailure(errorCode: Int) {
        view?.hideLoading()
        view?.onFetchMoviesFailure(error: "fetch movies error: \(errorCode)")
    }
    
    func getMovieSuccess(movie: MovieResult) {
        router?.pushToMovieDetailById(on: view!, with: movie)
    }
    
    func getMovieFailure() {
        view?.hideLoading()
        print("error retrieve movie by index")
    }
}
