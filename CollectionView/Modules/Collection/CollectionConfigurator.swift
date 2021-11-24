//
//  CollectionConfigurator.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//  
//

import UIKit

class CollectionConfigurator {
    func configure() -> UIViewController {
        let view = CollectionViewController()
        let presenter = CollectionPresenter()
        let router = CollectionRouter()
        let interactor = CollectionInteractor()
        
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
