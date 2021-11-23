//
//  News.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//

import Foundation

struct News {
    var author: String
    var title: String
    var description: String
    var image: String
    var publishedAt: Date
    var content: String
    
    init?(article: Article) {
        self.author = article.author
        self.title = article.title
        self.description = article.articleDescription
        self.image = article.urlToImage
        self.publishedAt = article.publishedAt
        self.content = article.content
    }
}
