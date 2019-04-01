//
//  ArticlesAdapter.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit

protocol ArticlesAdapterDelegate: class {
    
    func fetchMoreArticles()
    func showArticleDetail(article: Article)
    
}

class ArticlesAdapter: NSObject {
    
    fileprivate let articleCollectionView: UICollectionView
    fileprivate weak var delegate: ArticlesAdapterDelegate?
    
    var isLoading:Bool = false
    
    var articles: [Article] {
        didSet {
            self.articleCollectionView.reloadData()
            self.isLoading = false
        }
    }
    
    init(collectionView: UICollectionView, delegate: ArticlesAdapterDelegate) {
        self.articleCollectionView = collectionView
        self.delegate = delegate
        self.articles = [Article]()
        
        super.init()
        
        self.articleCollectionView.delegate = self
        
        self.registerCells()
    }
    
    func hideLoadMoreIndicator() {
        
        //self.footerView?.stopAnimate()
        isLoading = true
        self.articleCollectionView.reloadData()
    }
}

fileprivate extension ArticlesAdapter {
    // MARK: Setup Methods
    
    func registerCells() {
        let productNib = UINib.init(nibName: "ArticleCollectionViewCell", bundle: Bundle.main)
        self.articleCollectionView.register(productNib, forCellWithReuseIdentifier: "ArticleCollectionViewCell")
    }
}

extension ArticlesAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArticleCollectionViewCell.self),
                                                      for: indexPath) as! ArticleCollectionViewCell
        
        let article = self.articles[indexPath.item]
        cell.set(article: article)
        
        return cell
    }
}

extension ArticlesAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = self.articles[indexPath.item]
        self.delegate?.showArticleDetail(article: article)
    }
}

extension ArticlesAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 10, height: 100)
        
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
