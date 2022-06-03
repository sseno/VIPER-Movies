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
    
    var movies: Movie?
    private let genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.loadMovies(with: genre.id)
    }
    
    func setNavigationBarTitle() -> String {
        return genre.name ?? "Movies"
    }
    
    func numberOfRowsInSection() -> Int {
        guard let results = movies?.results else {
            return 0
        }
        return results.count
    }
    
    func setImageUrl(by indexPath: IndexPath) -> String? {
        guard let results = movies?.results, let path = results[indexPath.row].posterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w500/" + path
    }
    
    func setTextTitle(by indexPath: IndexPath) -> String? {
        guard let results = movies?.results else {
            return nil
        }
        return results[indexPath.row].title
    }
    
    func setTextOverview(by indexPath: IndexPath) -> String? {
        guard let results = movies?.results else {
            return nil
        }
        return results[indexPath.row].title
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveMovie(at: index)
    }
}

// MARK: - InteractorToPresenterMoviesProtocol
extension MoviesPresenter: InteractorToPresenterMoviesProtocol {
    
    func fetchMoviesSuccess(movies: Movie) {
        self.movies = movies
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
