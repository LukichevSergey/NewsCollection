//
//  NetworkNewsManager.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//

import Foundation
import Alamofire

class NetworkNewsManager {
    
    private let url: String = "https://newsapi.org/v2/everything?q=apple&from=2021-11-22&to=2021-11-22&sortBy=popularity&apiKey=85d0c7d63eac47fe944f2e7603eb8f6e"
    
    func sendRequest(completion: @escaping (_ news: [News])->()) {
        
        guard let url = URL(string: url) else { return }
        
        // Fetch Request
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                    case .success(let value):
                        guard let parsedDictionary = value as? [String: AnyObject] else {return}
                        var news: [News] = []
                        news = News.getArray(from: parsedDictionary["articles"] ?? [])!
                        completion(news)
                    case .failure(let error):
                        print(error)
                }
            }
    }
}
