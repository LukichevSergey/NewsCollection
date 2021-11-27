//
//  MainRouter.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 27.11.2021.
//  
//

import Foundation

// MARK: MainPresenterToRouterProtocol (Presenter -> Router)
protocol MainPresenterToRouterProtocol: AnyObject {
    func navigateToCollectionViewController(inputsData: [String : String])
}

class MainRouter {

    // MARK: Properties
    weak var view: MainRouterToViewProtocol!
}

// MARK: MainPresenterToRouterProtocol
extension MainRouter: MainPresenterToRouterProtocol {
    func navigateToCollectionViewController(inputsData: [String : String]) {
        view.pushView(view: CollectionConfigurator().configure(inputsData: inputsData))
    }
}
