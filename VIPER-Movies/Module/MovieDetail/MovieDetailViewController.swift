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
        let alertMessage = UIAlertController(title: "Oops!", message: "Error fetching movide detail with error: \(error)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
    
    func onFetchUserReviewSuccess() {
        node.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    func onFetchUserReviewFailure(error: String) {
        let alertMessage = UIAlertController(title: "Oops!", message: "Error fetching user review with error: \(error)", preferredStyle: .alert)
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
        switch section {
        case 0:
            return presenter?.numberOfRowsInSection() ?? 0
        default:
            return presenter?.numberOfReviewInSection() ?? 0
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        #warning("line 87, 92: need improvement")
        return {
            switch indexPath.section {
            case 0:
                guard let movieDetail = self.presenter?.movieDetail else {
                    return ASCellNode()
                }
                return MovieDetailCellNode(movieDetail: movieDetail)
            default:
                guard let userReviews = self.presenter?.userReview?.results, userReviews.count > 0 else {
                    return ASCellNode()
                }
                return MovieDetailReviewCellNode(userReviewResult: userReviews[indexPath.row])
            }
        }
    }
    
}

// MARK: - ASTableDelegate
extension MovieDetailViewController: ASTableDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let userReviews = self.presenter?.userReview?.results, userReviews.count > 0 else {
            return ""
        }
        return section == 1 ? "Users Review" : ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 16 : CGFloat.leastNormalMagnitude
    }
}
