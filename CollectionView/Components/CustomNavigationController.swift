//
//  CustomNavigationBar.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 25.11.2021.
//

import Foundation
import UIKit
import SnapKit

protocol CustomNavigationControllerDelegate: AnyObject {
    func goToPreviousController()
}

class CustomNavigationController: UIView {
    
    private var title: String = "" {
        didSet{
            newsTitle.text = title
        }
    }
    
    weak var delegate: CustomNavigationControllerDelegate?
    
    private lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    init(title: String = "", backButton: UIButton? = nil){
        super.init(frame: .zero)
        
        self.title = title
        
        if let backButton = backButton {
            backButton.addTarget(self, action: #selector(pressToButton), for: .touchUpInside)
            self.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).inset(10)
                make.centerY.equalTo(self.snp.centerY)
            }
        }
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        self.backgroundColor = .orange
        configureUI()
    }
    
    private func configureUI() {
        
        self.addSubview(newsTitle)
        newsTitle.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.left.greaterThanOrEqualTo(self.snp.left).inset(50)
            make.right.greaterThanOrEqualTo(self.snp.right).inset(50)
        }
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    @objc func pressToButton() {
        delegate?.goToPreviousController()
    }
}
