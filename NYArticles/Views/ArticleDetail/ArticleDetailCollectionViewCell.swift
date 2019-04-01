//
//  ArticleDetailCollectionViewCell.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit

class ArticleDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var articlePictureView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(article: Article) {
        if article.media.count > 0 {
            if article.media[0].metadata.count > 0 {
                let imagePath = article.media[0].metadata[0].url
                
                self.articlePictureView.sd_setImage(with: URL(string: imagePath))
            }
        }
        
        self.articleTitleLabel.text = article.title
        self.authorLabel.text = article.author
        self.articleDescriptionLabel.text = article.description
        self.dateLabel.text = article.date
    }
}
