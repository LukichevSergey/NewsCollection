//
//  CollectionInteractor.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//  
//

import Foundation

// MARK: CollectionPresenterToInteractorProtocol (Presenter -> Interactor)
protocol CollectionPresenterToInteractorProtocol: AnyObject {
    var data: [Cell] { get }
}

class CollectionInteractor {

    // MARK: Properties
    weak var presenter: CollectionInteractorToPresenterProtocol!

}

// MARK: CollectionPresenterToInteractorProtocol
extension CollectionInteractor: CollectionPresenterToInteractorProtocol {
    var data: [Cell] {
        var data: [Cell] = []
        for item in 1...100 {
            let cell = Cell(title: "\(item)")
            data.append(cell)
        }
        
//        let data: [Cell] = [
//            Cell(title: "1"), Cell(title: "2"), Cell(title: "3"), Cell(title: "4"), Cell(title: "5"), Cell(title: "6")
//        ]
        return data
    }
}
