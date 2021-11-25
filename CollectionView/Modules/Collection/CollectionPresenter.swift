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
    func clickOnItem(indexPath: IndexPath)
}

// MARK: CollectionInteractorToPresenterProtocol (Interactor -> Presenter)
protocol CollectionInteractorToPresenterProtocol: AnyObject {
    func didFinishFetchDataFromApi(data: [News])
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
        interactor.fetchDataFromApi()
    }
    
    func clickOnItem(indexPath: IndexPath) {
        router.navigateToItemViewController(item: interactor.getItemForIndexPath(indexPath: indexPath))
    }
}

// MARK: CollectionInteractorToPresenterProtocol
extension CollectionPresenter: CollectionInteractorToPresenterProtocol {
    func didFinishFetchDataFromApi(data: [News]) {
        DispatchQueue.main.async {
            self.view.updateCollection(with: data)
        }
    }
}
