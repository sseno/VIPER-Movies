//
//  MovieDetailCellNode.swift
//  VIPER-Movies
//
//  Created by Seno on 04/06/22.
//

import AsyncDisplayKit

class MovieDetailCellNode: ASCellNode {

    private let imageNode: ASNetworkImageNode
    private let titleNode: ASTextNode
    private let releaseDateValue: ASTextNode
    private let ratingNode: ASTextNode
    private let overviewNode: ASTextNode
    
    init(movieDetail: MovieDetail) {
        imageNode = ASNetworkImageNode()
        imageNode.url = URL(string: "https://image.tmdb.org/t/p/w500/"+(movieDetail.backdropPath ?? ""))
        
        titleNode = ASTextNode()
        titleNode.attributedText = NSAttributedString(
            string: movieDetail.title ?? "",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
        )
        
        releaseDateValue = ASTextNode()
        releaseDateValue.attributedText = NSAttributedString(
            string: "Release Date: \(movieDetail.releaseDate ?? "")",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
        )
        
        ratingNode = ASTextNode()
        ratingNode.attributedText = NSAttributedString(
            string: "Rating: \(movieDetail.voteAverage ?? 0)/10",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
        )
        
        overviewNode = ASTextNode()
        overviewNode.attributedText = NSAttributedString(
            string: movieDetail.overview ?? "",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular)
            ]
        )
        
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = .init(width: constrainedSize.max.width, height: 300)
        
        let contentVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children:
                [titleNode,
                 releaseDateValue,
                 ratingNode,
                 overviewNode])
        
        let contentInset = ASInsetLayoutSpec(insets: .init(top: 8, left: 16, bottom: 16, right: 16), child: contentVStack)
        
        let vStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [imageNode, contentInset])
        
        return vStack
    }
    
}
