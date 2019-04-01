//
//  ArticlesDetailAdapter.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit

protocol ArticleDetailAdapterDelegate: class {
    
    func showArticle(article: Article)
}

class ArticleDetailAdapter: NSObject {
    
    fileprivate let articleDetailCollectionView: UICollectionView
    fileprivate weak var delegate: ArticleDetailAdapterDelegate?
    
    var article: Article {
        didSet {
            self.articleDetailCollectionView.reloadData()
        }
    }
    
    init(collectionView: UICollectionView, delegate: ArticleDetailAdapterDelegate, article: Article) {
        self.articleDetailCollectionView = collectionView
        self.article = article
        super.init()
        
        self.delegate = delegate
        self.articleDetailCollectionView.delegate = self
        
        self.registerCells()
    }
}

fileprivate extension ArticleDetailAdapter {
    // MARK: Setup Methods
    
    func registerCells() {
        
        let productNib = UINib.init(nibName: "ArticleDetailCollectionViewCell", bundle: Bundle.main)
        self.articleDetailCollectionView.register(productNib, forCellWithReuseIdentifier: "ArticleDetailCollectionViewCell")
    }
}

extension ArticleDetailAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArticleDetailCollectionViewCell.self),
                                                      for: indexPath) as! ArticleDetailCollectionViewCell
        
        cell.set(article: self.article)
        
        return cell
    }
}

extension ArticleDetailAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ArticleDetailAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 10, height: 400)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
