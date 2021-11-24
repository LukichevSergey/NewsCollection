//
//  UIImageView + extensions.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
