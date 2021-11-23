//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(withItemModel model: Cell) {
        self.backgroundColor = .black
        self.title.text = model.title
    }
    
    private func commonInit() {
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self)
        }
    }
}
