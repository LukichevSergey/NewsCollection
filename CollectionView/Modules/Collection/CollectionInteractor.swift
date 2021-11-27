//
//  CollectionInteractor.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//  
//

import Foundation

// MARK: CollectionPresenterToInteractorProtocol (Presenter -> Interactor)
protocol CollectionPresenterToInteractorProtocol: AnyObject {
    func getItemForIndexPath(indexPath: IndexPath) -> News
    func fetchDataFromApi()
}

class CollectionInteractor {

    // MARK: Properties
    weak var presenter: CollectionInteractorToPresenterProtocol!
    private let networkNewsManager: NetworkNewsManager
    
    private var news: [News] = []
    
    private var paramsForQuery: [String : String] = [
        "q" : "",
        "from" : "",
        "to" : "",
        "sortBy" : "popularity",
        "apiKey" : "85d0c7d63eac47fe944f2e7603eb8f6e"
    ]
    
    init(inputsData: [String : String]) {
        networkNewsManager = NetworkNewsManager()
        paramsForQuery["q"] = inputsData["searchInput"]
        paramsForQuery["from"] = inputsData["dateFromInput"]
        paramsForQuery["to"] = inputsData["dateToInput"]
    }
}

// MARK: CollectionPresenterToInteractorProtocol
extension CollectionInteractor: CollectionPresenterToInteractorProtocol {
    
    func fetchDataFromApi() {        
        networkNewsManager.sendRequest(apiAndPoint: .mainPage(params: paramsForQuery), completion: { [weak self] news in
            self?.news = news
            self?.presenter.didFinishFetchDataFromApi(data: news)
        })
    }
    
    func getItemForIndexPath(indexPath: IndexPath) -> News {
        return news[indexPath.row]
    }
}
