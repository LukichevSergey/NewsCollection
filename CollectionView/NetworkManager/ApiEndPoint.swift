//
//  ApiEndPoint.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 25.11.2021.
//

import Foundation
import Alamofire

public enum ApiEndPoint {
    case mainPage(params: [String : String])
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
        case let .mainPage(params):
            params.forEach {
                items.append(URLQueryItem(name: $0, value: $1))
            }
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
