//
//  CustomNavigationBar.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 25.11.2021.
//

import Foundation
import UIKit
import SnapKit

class CustomNavigationController: UIView {
    
    private var title: String = "" {
        didSet{
            newsTitle.text = title
        }
    }
    private var backButton: Bool = false
    
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
    
    private lazy var backNewsButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(pressToButton), for: .touchUpInside)
        return button
    }()
    
    init(title: String = "", backButton: Bool = false){
        super.init(frame: .zero)
        
        self.title = title
        self.backButton = backButton
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
            make.bottom.equalTo(self).inset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.left.greaterThanOrEqualTo(self.snp.left).inset(50)
            make.right.greaterThanOrEqualTo(self.snp.right).inset(50)
        }
        
        if backButton == true {
            self.addSubview(backNewsButton)
            backNewsButton.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).inset(10)
                make.bottom.equalTo(self).inset(-5)
            }
        }
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    @objc func pressToButton() {
        delegate?.goToPreviousController()
    }
}
