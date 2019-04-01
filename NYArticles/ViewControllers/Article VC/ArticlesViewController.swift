//
//  ArticlesViewController.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit

protocol ArticleView: BaseView {
    func show(articles: [Article], count: Int)
    func showActivityIndicator(withMessage message: String)
    func hideActivityIndicator()
}

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    fileprivate var articlesAdapter: ArticlesAdapter!
    fileprivate var articlesPresenter: ArticlesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("NY Times Most Popular", comment: "")
        
        self.setupAdapter()
        self.setupPresenter()
        
        self.articlesPresenter.fetchArticles(withOffset: 0, count: 20)
    }
}

fileprivate extension ArticlesViewController {
    // MARK: Setup Methods
    
    func setupAdapter() {
        self.articlesAdapter = ArticlesAdapter(collectionView: self.articleCollectionView, delegate: self)
        self.articleCollectionView.dataSource = self.articlesAdapter
    }
    
    func setupPresenter() {
        let articleInteractor = ArticlesInteractor(networkClient: NetworkingClient())
        self.articlesPresenter = ArticlesPresenter(articleInteractor: articleInteractor, articleView: self)
    }
}

extension ArticlesViewController: ArticlesAdapterDelegate {
    // MARK: ProductAdapterDelegate
    
    func fetchMoreArticles() {
        self.articlesPresenter.fetchArticles(withOffset: 0, count: 20)
    }
    
    func showArticleDetail(article: Article) {
        
        let articleDetailsVC = ArticleDetailViewController.viewController()
        articleDetailsVC.article = article
        self.navigationController?.pushViewController(articleDetailsVC, animated: true)
    }
}

extension ArticlesViewController: ArticleView {
    
    func show(articles: [Article], count: Int) {
        
        var currentItems = self.articlesAdapter.articles
        currentItems.append(contentsOf: articles)
        self.articlesAdapter.articles = currentItems
    }
    
    func showActivityIndicator(withMessage message: String) {
        self.showLoading(withMessage: "Loading...")
    }
    
    func hideActivityIndicator() {
        self.hideLoading()
    }
}
