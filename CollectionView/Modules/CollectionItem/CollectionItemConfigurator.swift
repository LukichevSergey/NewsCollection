//
//  CollectionItemConfigurator.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//  
//

import UIKit

class CollectionItemConfigurator {
    func configure(item: News) -> UIViewController {
        let view = CollectionItemViewController()
        let presenter = CollectionItemPresenter()
        let router = CollectionItemRouter()
        let interactor = CollectionItemInteractor(item: item)
        
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
