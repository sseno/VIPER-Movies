//
//  MovieDetailReviewCellNode.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import AsyncDisplayKit

class MovieDetailReviewCellNode: ASCellNode {

    private let authorNode: ASTextNode
    private let contentNode: ASTextNode
    
    init(userReviewResult: UserReviewResult) {
        authorNode = ASTextNode()
        authorNode.attributedText = NSAttributedString(
            string: userReviewResult.author ?? "",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
        )
        
        contentNode = ASTextNode()
        contentNode.attributedText = NSAttributedString(
            string: userReviewResult.content ?? "",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
        )
        
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let vStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [authorNode,
                      contentNode])
        
        return ASInsetLayoutSpec(insets: .init(top: 8, left: 16, bottom: 16, right: 16), child: vStack)
    }
}
