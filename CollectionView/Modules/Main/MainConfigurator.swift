//
//  MainConfigurator.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 27.11.2021.
//  
//

import UIKit

class MainConfigurator {
    func configure() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()
        let interactor = MainInteractor()
        
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
