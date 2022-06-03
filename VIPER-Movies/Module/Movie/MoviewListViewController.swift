//
//  MoviewListViewController.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import AsyncDisplayKit

class MoviewListViewController: ASDKViewController<ASTableNode> {

    var presenter: ViewToPresenterMoviesProtocol?
    
    override init() {
        super.init(node: ASTableNode())
        node.backgroundColor = .white
        node.dataSource = self
        node.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        title = presenter?.setNavigationBarTitle()
    }

}

// MARK: - PresenterToViewMoviesProtocol
extension MoviewListViewController: PresenterToViewMoviesProtocol {
    
    func onFetchMoviesSuccess() {
        node.reloadData()
    }
    
    func onFetchMoviesFailure(error: String) {
        print("Error from presenter with error: \(error)")
    }
    
    func showLoading() {
        self.showLoadingHUD()
    }
    
    func hideLoading() {
        self.hideLoadingHUD()
    }
}

// MARK: - ASTableDataSource
extension MoviewListViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return presenter?.movies?.results?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let movieResult = self.presenter?.movies?.results, movieResult.count > indexPath.row else {
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

