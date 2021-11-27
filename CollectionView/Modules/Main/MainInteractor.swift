//
//  MainInteractor.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 27.11.2021.
//  
//

import Foundation

// MARK: MainPresenterToInteractorProtocol (Presenter -> Interactor)
protocol MainPresenterToInteractorProtocol: AnyObject {

}

class MainInteractor {

    // MARK: Properties
    weak var presenter: MainInteractorToPresenterProtocol!

}

// MARK: MainPresenterToInteractorProtocol
extension MainInteractor: MainPresenterToInteractorProtocol {
    
}