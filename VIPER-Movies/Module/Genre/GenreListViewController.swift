//
//  GenreListViewController.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import AsyncDisplayKit

class GenreListViewController: ASDKViewController<ASTableNode> {
    
    // MARK: - Properties
    var presenter: ViewToPresenterGenresProtocol?

    override init() {
        super.init(node: ASTableNode())
        title = "Genres"
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
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    }

}

// MARK: - PresenterToViewGenresProtocol
extension GenreListViewController: PresenterToViewGenresProtocol {
    
    func onFetchGenresSuccess() {
        node.reloadData()
    }
    
    func onFetchGenresFailure(error: String) {
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
extension GenreListViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return presenter?.genreList?.genres?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let genreList = self.presenter?.genreList?.genres, genreList.count > indexPath.row else {
            return { ASCellNode() }
        }
        return {
            let cellNode = ASTextCellNode()
            cellNode.textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            cellNode.text = self.presenter?.setTextNode(by: indexPath)
            return cellNode
        }
    }
}

// MARK: - ASTableDelegate
extension GenreListViewController: ASTableDelegate {
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
}
