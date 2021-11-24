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
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 3
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(withItemModel model: News) {
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 3
        self.title.text = model.title
        if let newsImage = model.image {
            self.image.setImage(imageUrl: newsImage)
        }
    }
    
    private func commonInit() {
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(5)
            make.left.right.equalTo(self).inset(5)
        }
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(150)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).inset(10)
            make.bottom.lessThanOrEqualTo(title.snp.top).inset(-10)
        }
    }
}
