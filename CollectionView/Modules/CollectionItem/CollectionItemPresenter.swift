//
//  CollectionItemPresenter.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//  
//

import Foundation

// MARK: CollectionItemViewToPresenterProtocol (View -> Presenter)
protocol CollectionItemViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func clickBackButton()
}

// MARK: CollectionItemInteractorToPresenterProtocol (Interactor -> Presenter)
protocol CollectionItemInteractorToPresenterProtocol: AnyObject {
}

class CollectionItemPresenter {

    // MARK: Properties
    var router: CollectionItemPresenterToRouterProtocol!
    var interactor: CollectionItemPresenterToInteractorProtocol!
    weak var view: CollectionItemPresenterToViewProtocol!
}

// MARK: CollectionItemViewToPresenterProtocol
extension CollectionItemPresenter: CollectionItemViewToPresenterProtocol {
    func viewDidLoad() {
        view.loadNewsData(data: interactor.getNewsData)
    }
    
    func clickBackButton() {
        router.backToCollectionViewController()
    }
}

// MARK: CollectionItemInteractorToPresenterProtocol
extension CollectionItemPresenter: CollectionItemInteractorToPresenterProtocol {
}
