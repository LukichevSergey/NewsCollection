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
    
    init() {
        networkNewsManager = NetworkNewsManager()
    }
}

// MARK: CollectionPresenterToInteractorProtocol
extension CollectionInteractor: CollectionPresenterToInteractorProtocol {
    
    func fetchDataFromApi() {
        networkNewsManager.sendRequest { [weak self] news in
            self?.news = news
            self?.presenter.didFinishFetchDataFromApi(data: news)
        }
    }
    
    func getItemForIndexPath(indexPath: IndexPath) -> News {
        return news[indexPath.row]
    }
}
