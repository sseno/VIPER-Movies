//
//  MovieInteractor.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class MovieInteractor: PresenterToInteractorMoviesProtocol {
    
    weak var presenter: InteractorToPresenterMoviesProtocol?
    
    var movieResults: [MovieResult] = []
    
    private let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
    
    func loadMovies(page: Int, with genreId: Int?) {
        guard let genreId = genreId else {
            return
        }

        service.requestMovieList(page: page, by: genreId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    if page == 1 {
                        if let movieResults = response.results {
                            self.movieResults = movieResults
                        }
                        self.presenter?.fetchMoviesSuccess(movieResults: self.movieResults)
                    } else {
                        if let movieResults = response.results {
                            self.movieResults.append(contentsOf: movieResults)
                        }
                        self.presenter?.fetchMoviesSuccess(movieResults: self.movieResults)
                    }
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
        guard movieResults.count > 0 else {
            presenter?.getMovieFailure()
            return
        }
        presenter?.getMovieSuccess(movie: movieResults[index])
    }
}
