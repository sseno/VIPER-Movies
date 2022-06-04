//
//  MovideDetailVideoCollectionNode.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import AsyncDisplayKit
import WebKit

class MovideDetailVideoCollectionNode: ASCellNode {

    var collectionNode: ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        collectionNode.showsHorizontalScrollIndicator = false
        collectionNode.style.width = ASDimension(unit: .auto, value: 1)
        collectionNode.style.height = ASDimension(unit: .points, value: 190)
        collectionNode.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionNode.backgroundColor = .white
        return collectionNode
    }()
    
    private let videoTrailer: VideoTrailer
    
    init(videoTrailer: VideoTrailer) {
        self.videoTrailer = videoTrailer
        
        super.init()
        automaticallyManagesSubnodes = true
        collectionNode.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: collectionNode)
    }
}

// MARK: - ASCollectionDataSource
extension MovideDetailVideoCollectionNode: ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return videoTrailer.results?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let videoTrailers = self.videoTrailer.results, videoTrailers.count > indexPath.row else {
            return { ASCellNode() }
        }
        return {
            VideoTrailerCellNode(videoKey: videoTrailers[indexPath.item].key ?? "")
        }
    }
}

// MARK: - VideoTrailerCellNode
class VideoTrailerCellNode: ASCellNode {

    lazy var contentWebView = ASDisplayNode(viewBlock: { () -> UIView in
        let webView = WKWebView(frame: .zero)
        return webView
    })
    
    private let videoKey: String
    
    init(videoKey: String) {
        self.videoKey = videoKey
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        contentWebView.style.preferredSize = .init(width: 260, height: 190)
        
        return ASWrapperLayoutSpec(layoutElement: contentWebView)
    }
    
    override func didLoad() {
        super.didLoad()
        let webView = contentWebView.view as? WKWebView
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") else {
            return
        }
        webView?.load(URLRequest(url: url))
    }
}
