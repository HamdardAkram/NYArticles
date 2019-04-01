//
//  ArticlesPresenter.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import Foundation

protocol ArticlesPresenterProtocol {
    func fetchArticles(withOffset: Int, count: Int)
}

typealias Page = Int

enum State {
    case loading
    case ready
}

class ArticlesPresenter: ArticlesPresenterProtocol {
    
    fileprivate let articlesInteractor: ArticlesInteractorProtocol
    fileprivate weak var articleView: ArticleView?
    
    fileprivate var loadingState: [Page: State] = [0: State.ready]
    fileprivate var totalArticles: Int = 0
    
    init(articleInteractor: ArticlesInteractorProtocol, articleView: ArticleView) {
        self.articlesInteractor = articleInteractor
        self.articleView = articleView
    }
    
    func fetchArticles(withOffset: Int, count: Int) {
        if withOffset >= totalArticles && withOffset > 0 {
            self.articleView?.hideActivityIndicator()
            print("No more products")
            return
        }
        if loadingState[withOffset] == State.loading {
            return
        }
        loadingState[withOffset] = State.loading
        
        self.articleView?.showActivityIndicator(withMessage: "Loading..")
        self.articlesInteractor.fetchArticles(withOffset: withOffset, count: count, success: { (articles, articleCount) in
            self.loadingState[withOffset] = State.ready
            self.totalArticles = articleCount
            self.articleView?.show(articles: articles, count: articleCount)
            self.articleView?.hideActivityIndicator()
        }) { (error) in
            self.loadingState[withOffset] = State.ready
            self.articleView?.hideActivityIndicator()
            self.articleView?.showError(error: error)
        }
    }
}
