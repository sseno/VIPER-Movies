//
//  MovieCellNode.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import AsyncDisplayKit
import Foundation

class MovieCellNode: ASCellNode {

    private let imageNode: ASNetworkImageNode
    private let titleNode: ASTextNode
    private let overviewNode: ASTextNode
    
    init(imageUrl: String, title: String?, overview: String?) {
        imageNode = ASNetworkImageNode()
        imageNode.url = URL(string: imageUrl)
        
        titleNode = ASTextNode()
        titleNode.attributedText = NSAttributedString(
            string: title ?? "",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
        )
        
        overviewNode = ASTextNode()
        overviewNode.attributedText = NSAttributedString(
            string: overview ?? "",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular)
            ]
        )
        
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = .init(width: 120, height: 180)
        
        let titleVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [titleNode, overviewNode])

        titleVStack.style.flexShrink = 1
        
        let hStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [imageNode, titleVStack])
        
        return ASInsetLayoutSpec(
            insets: .init(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16),
            child: hStack)
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.layer.cornerRadius = 8
    }
}
