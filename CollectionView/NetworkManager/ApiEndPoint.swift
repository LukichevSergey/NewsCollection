//
//  ApiEndPoint.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 25.11.2021.
//

import Foundation
import Alamofire

public enum ApiEndPoint {
    case mainPage
}

extension ApiEndPoint {
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        return "newsapi.org"
    }
    
    private var path: String {
        switch self {
            case .mainPage: return "/v2/everything"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        
        switch self {
        case .mainPage:
            items.append(URLQueryItem(name: "q", value: "apple"))
            items.append(URLQueryItem(name: "from", value: "2021-11-22"))
            items.append(URLQueryItem(name: "to", value: "2021-11-22"))
            items.append(URLQueryItem(name: "sortBy", value: "popularity"))
            items.append(URLQueryItem(name: "apiKey", value: "85d0c7d63eac47fe944f2e7603eb8f6e"))
        }
        
        return items
    }
    
    var headers: HTTPHeaders {
        let items = [HTTPHeader]()
        
        return HTTPHeaders(items)
    }

    var parameters: Parameters {
        let items = Parameters()

        return items
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .mainPage: return .get
        }
    }

    private func configureURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    var url: URL? {
        return configureURL()
    }
}
