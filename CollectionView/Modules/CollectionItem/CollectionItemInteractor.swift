//
//  CollectionItemInteractor.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//  
//

import Foundation

// MARK: CollectionItemPresenterToInteractorProtocol (Presenter -> Interactor)
protocol CollectionItemPresenterToInteractorProtocol: AnyObject {
    var getNewsData: News { get }
}

class CollectionItemInteractor {

    // MARK: Properties
    weak var presenter: CollectionItemInteractorToPresenterProtocol!
    private let currentNews: News
    
    init(item: News) {
        currentNews = item
    }

}

// MARK: CollectionItemPresenterToInteractorProtocol
extension CollectionItemInteractor: CollectionItemPresenterToInteractorProtocol {
    var getNewsData: News {
        return currentNews
    }
}
