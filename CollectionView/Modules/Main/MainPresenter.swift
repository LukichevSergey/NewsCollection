//
//  MainPresenter.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 27.11.2021.
//  
//

import Foundation

// MARK: MainViewToPresenterProtocol (View -> Presenter)
protocol MainViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func clickOnSuccessButton(inputsData: [String : String])
}

// MARK: MainInteractorToPresenterProtocol (Interactor -> Presenter)
protocol MainInteractorToPresenterProtocol: AnyObject {

}

class MainPresenter {

    // MARK: Properties
    var router: MainPresenterToRouterProtocol!
    var interactor: MainPresenterToInteractorProtocol!
}

// MARK: MainViewToPresenterProtocol
extension MainPresenter: MainViewToPresenterProtocol {
    func viewDidLoad() {
    
    }
    
    func clickOnSuccessButton(inputsData: [String : String]) {
        router.navigateToCollectionViewController(inputsData: inputsData)
    }
}

// MARK: MainInteractorToPresenterProtocol
extension MainPresenter: MainInteractorToPresenterProtocol {
    
}
