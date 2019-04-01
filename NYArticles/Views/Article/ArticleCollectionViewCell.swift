//
//  ArticleCollectionViewCell.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var articleThumbnailView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.articleThumbnailView.clipsToBounds = true
        self.articleThumbnailView.layer.cornerRadius = self.articleThumbnailView.frame.width/2
    }

    func set(article: Article) {
        if article.media.count > 0 {
            if article.media[0].metadata.count > 0 {
                let imagePath = article.media[0].metadata[0].url
                
                self.articleThumbnailView.sd_setImage(with: URL(string: imagePath))
            }
        }
        
        self.articleTitleLabel.text = article.title
        self.articleDescriptionLabel.text = article.author
        self.dateLabel.text = article.date
    }
}
