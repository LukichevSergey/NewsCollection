//
//  NetworkNewsManager.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//

import Foundation
import Alamofire

class NetworkNewsManager {
    
    func sendRequest(apiAndPoint: ApiEndPoint, completion: @escaping (_ news: [News])->()) {
        
        guard let url = apiAndPoint.url else { return }
        
        // Fetch Request
        AF.request(url, method: apiAndPoint.httpMethod)
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
