//
//  NetworkNewsManager.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//

import Foundation
import Alamofire

class NetworkNewsManager {
    
    private let url: String = "https://newsapi.org/v2/everything?q=apple&from=2021-11-22&to=2021-11-22&sortBy=popularity&apiKey=530653e4a02144378e6829279aa7c8c9"
    
    func sendRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
    }
}
