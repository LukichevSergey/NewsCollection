//
//  News.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//

import Foundation

struct News: Codable, Hashable {
    var author: String?
    var title: String?
    var description: String?
    var image: String?
    var publishedAt: String?
    var content: String?
    
    init?(json: [String : Any]) {

        let author = json["author"] as? String
        let title = json["title"] as? String
        let description = json["description"] as? String
        let image = json["urlToImage"] as? String
        let publishedAt = json["publishedAt"] as? String
        let content = json["content"] as? String

        self.author = author
        self.title = title
        self.description = description
        self.image = image
        self.publishedAt = publishedAt
        self.content = content
    }

    static func getArray(from jsonArray: Any) -> [News]? {
        guard let jsonArray = jsonArray as? Array<[String:Any]> else { return nil }
        return jsonArray.compactMap {News(json: $0)}
    }
}
