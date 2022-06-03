//
//  GenresInteractor.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import Foundation

class GenresInteractor: PresenterToInteractorGenresProtocol {
    
    // MARK: - Properties
    var presenter: InteractorToPresenterGenresProtocol?
    var genreList: GenreList?
    
    private let service: GenreService

    init(servcie: GenreService) {
        self.service = servcie
    }
    
    func loadGenres() {
        service.requestGenreList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.genreList = response
                    self.presenter?.fetchGenresSuccess(genreList: response)
                }
            case .failure(let error):
                switch error {
                case .serverError(statusCode: let code):
                    self.presenter?.fetchGenresFailure(errorCode: code)
                default:
                    break
                }
            }
        }
    }
    
    func retrieveGenre(at index: Int) {
        guard let genres = genreList?.genres else {
            presenter?.getGenreFailure()
            return
        }
        presenter?.getGenreSuccess(genre: genres[index])
    }
}
