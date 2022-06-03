//
//  MovieInteractor.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class MovieInteractor: PresenterToInteractorMoviesProtocol {
    
    weak var presenter: InteractorToPresenterMoviesProtocol?
    var movies: Movie?
    
    private let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
    
    func loadMovies(with genreId: Int?) {
        guard let genreId = genreId else {
            return
        }

        service.requestMovieList(page: 1, by: genreId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.movies = response
                    self.presenter?.fetchMoviesSuccess(movies: response)
                }
            case .failure(let error):
                switch error {
                case .serverError(statusCode: let code):
                    self.presenter?.fetchMoviesFailure(errorCode: code)
                default:
                    break
                }
            }
        }
    }
    
    func retrieveMovie(at index: Int) {
        guard let results = movies?.results else {
            presenter?.getMovieFailure()
            return
        }
        presenter?.getMovieSuccess(movie: results[index])
    }
}
