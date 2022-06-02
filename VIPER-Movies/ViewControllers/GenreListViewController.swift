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
        node.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    }

}

// MARK: - ASTableDataSource
extension GenreListViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let cellNode = ASTextCellNode()
            cellNode.textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            cellNode.text = "\(indexPath.row)"
            return cellNode
        }
    }
}
