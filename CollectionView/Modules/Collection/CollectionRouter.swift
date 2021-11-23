//
//  CollectionRouter.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//  
//

import Foundation

// MARK: CollectionPresenterToRouterProtocol (Presenter -> Router)
protocol CollectionPresenterToRouterProtocol: AnyObject {

}

class CollectionRouter {

    // MARK: Properties
    weak var view: CollectionRouterToViewProtocol!
}

// MARK: CollectionPresenterToRouterProtocol
extension CollectionRouter: CollectionPresenterToRouterProtocol {
    
}