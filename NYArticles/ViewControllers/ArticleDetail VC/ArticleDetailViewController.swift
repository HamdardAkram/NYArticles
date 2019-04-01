//
//  ArticleDetailViewController.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit


class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleDetailCollectionView: UICollectionView!
    
    fileprivate var articleDetailAdapter: ArticleDetailAdapter!
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupAdapter()
        self.articleDetailAdapter.article = article!
    }
    
    class func viewController() -> ArticleDetailViewController {
        let articleDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ArticleDetailViewController.self)) as! ArticleDetailViewController
        
        return articleDetailsVC
    }
}

fileprivate extension ArticleDetailViewController {
    // MARK: Setup Methods
    
    func setupAdapter() {
        self.articleDetailAdapter = ArticleDetailAdapter(collectionView: self.articleDetailCollectionView, delegate: self, article: self.article!)
        self.articleDetailCollectionView.dataSource = self.articleDetailAdapter
    }
}

extension ArticleDetailViewController: ArticleDetailAdapterDelegate {
    
    func showArticle(article: Article) {
        let articleDetailsVC = ArticleDetailViewController.viewController()
        articleDetailsVC.article = article
        self.navigationController?.pushViewController(articleDetailsVC, animated: true)
    }
}
