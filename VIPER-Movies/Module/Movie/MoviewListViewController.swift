//
//  MoviewListViewController.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import AsyncDisplayKit

class MoviewListViewController: ASDKViewController<ASTableNode> {

    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    var presenter: ViewToPresenterMoviesProtocol?
    
    override init() {
        super.init(node: ASTableNode())
        node.backgroundColor = .white
        node.dataSource = self
        node.delegate = self
        node.allowsMultipleSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePullToRefresh()
        presenter?.viewDidLoad()
        title = presenter?.setNavigationBarTitle()
    }
    
    // MARK: - PullToRefresh
    private func configurePullToRefresh() {
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        node.view.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.pullToRefresh()
    }
    
    // MARK: - Loadmore
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((node.contentOffset.y + node.frame.size.height) >= node.view.contentSize.height) {
            presenter?.didEndScrolling()
        }
    }

}

// MARK: - PresenterToViewMoviesProtocol
extension MoviewListViewController: PresenterToViewMoviesProtocol {
    
    func onFetchMoviesSuccess() {
        node.reloadData()
    }
    
    func onFetchMoviesFailure(error: String) {
        let alertMessage = UIAlertController(title: "Oops!", message: "Error fetching movies with error: \(error)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
    
    func showLoading() {
        self.showLoadingHUD()
    }
    
    func hideLoading() {
        self.hideLoadingHUD()
        refreshControl.endRefreshing()
    }
    
    func deselectRowAt(indexPath: IndexPath) {
        node.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ASTableDataSource
extension MoviewListViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let movieResult = self.presenter?.movieResuls, movieResult.count > indexPath.row else {
            return { ASCellNode() }
        }
        
        guard let imageUrl = self.presenter?.setImageUrl(by: indexPath) else {
            return { ASCellNode() }
        }
        return {
            MovieCellNode(
                imageUrl: imageUrl,
                title: self.presenter?.setTextTitle(by: indexPath),
                overview: self.presenter?.setTextOverview(by: indexPath))
        }
    }
}

// MARK: - ASTableDelegate
extension MoviewListViewController: ASTableDelegate {
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
        presenter?.deselectRowAt(indexPath: indexPath)
    }
}
