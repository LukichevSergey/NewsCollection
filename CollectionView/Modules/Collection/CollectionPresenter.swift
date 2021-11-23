//
//  CollectionPresenter.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//  
//

import Foundation

// MARK: CollectionViewToPresenterProtocol (View -> Presenter)
protocol CollectionViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
}

// MARK: CollectionInteractorToPresenterProtocol (Interactor -> Presenter)
protocol CollectionInteractorToPresenterProtocol: AnyObject {

}

class CollectionPresenter {

    // MARK: Properties
    var router: CollectionPresenterToRouterProtocol!
    var interactor: CollectionPresenterToInteractorProtocol!
    weak var view: CollectionPresenterToViewProtocol!
}

// MARK: CollectionViewToPresenterProtocol
extension CollectionPresenter: CollectionViewToPresenterProtocol {
    func viewDidLoad() {
        updateCollection()
    }
}

// MARK: CollectionInteractorToPresenterProtocol
extension CollectionPresenter: CollectionInteractorToPresenterProtocol {
    private func updateCollection() {
        DispatchQueue.main.async {
            self.view.updateCollection(with: self.interactor.data)
        }
    }
}
