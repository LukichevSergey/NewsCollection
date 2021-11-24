//
//  CollectionItemRouter.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//  
//

import Foundation

// MARK: CollectionItemPresenterToRouterProtocol (Presenter -> Router)
protocol CollectionItemPresenterToRouterProtocol: AnyObject {
    func backToCollectionViewController()
}

class CollectionItemRouter {

    // MARK: Properties
    weak var view: CollectionItemRouterToViewProtocol!
}

// MARK: CollectionItemPresenterToRouterProtocol
extension CollectionItemRouter: CollectionItemPresenterToRouterProtocol {
    func backToCollectionViewController() {
        view.popView()
    }
}
