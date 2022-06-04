//
//  MovieDetailViewController.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import AsyncDisplayKit

class MovieDetailViewController: ASDKViewController<ASTableNode> {
    
    var presenter: ViewToPresenterMovieDetailProtocol?
    
    override init() {
        super.init(node: ASTableNode(style: .grouped))
        node.backgroundColor = .white
        node.dataSource = self
        node.delegate = self
        node.allowsMultipleSelection = false
        node.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        title = "Details"
    }
}

// MARK: - PresenterToViewMovieDetailProtocol
extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    
    func onFetchMovieDetailSuccess() {
        node.reloadData()
    }
    
    func onFetchMovieDetailFailure(error: String) {
        let alertMessage = UIAlertController(title: "Oops!", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
    
    func onFetchVideoTrailerSuccess() {
        node.reloadSections(IndexSet(integer: MovieDetailTableSection.trailers.rawValue), with: .none)
    }
    
    func onFetchVideoTrailerFailure(error: String) {
        let alertMessage = UIAlertController(title: "Oops!", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
    
    func onFetchUserReviewSuccess() {
        node.reloadSections(IndexSet(integer: MovieDetailTableSection.reviews.rawValue), with: .none)
    }
    
    func onFetchUserReviewFailure(error: String) {
        let alertMessage = UIAlertController(title: "Oops!", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
    
    func showLoading() {
        self.showLoadingHUD()
    }
    
    func hideLoading() {
        self.hideLoadingHUD()
    }
}

// MARK: - ASTableDataSource
extension MovieDetailViewController: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        switch MovieDetailTableSection(rawValue: section) {
        case .details:
            return presenter?.numberOfRowsInSection() ?? 0
        case .trailers:
            return 1
        case .reviews:
            return presenter?.numberOfReviewInSection() ?? 0
        default:
            return 0
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            switch MovieDetailTableSection(rawValue: indexPath.section) {
            case .details:
                guard let movieDetail = self.presenter?.movieDetail else {
                    return ASCellNode()
                }
                return MovieDetailCellNode(movieDetail: movieDetail) // need improvement
            case .trailers:
                guard let videoTrailer = self.presenter?.videoTrailer else {
                    return ASCellNode()
                }
                return MovideDetailVideoCollectionNode(videoTrailer: videoTrailer) // need improvement
            case .reviews:
                guard let userReviews = self.presenter?.userReview?.results, userReviews.count > 0 else {
                    return ASCellNode()
                }
                return MovieDetailReviewCellNode(userReviewResult: userReviews[indexPath.row]) // need improvement
            default:
                return ASCellNode()
            }
        }
    }
    
}

// MARK: - ASTableDelegate
extension MovieDetailViewController: ASTableDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch MovieDetailTableSection(rawValue: section) {
        case .trailers:
            return "Video Trailer"
        case .reviews:
            guard let userReviews = self.presenter?.userReview?.results, userReviews.count > 0 else {
                return ""
            }
            return "Users Review"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch MovieDetailTableSection(rawValue: section) {
        case .trailers, .reviews:
            return 16
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
}
