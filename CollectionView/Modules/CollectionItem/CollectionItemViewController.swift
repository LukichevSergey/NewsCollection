//
//  CollectionItemViewController.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//  
//

import UIKit
import SnapKit

// MARK: CollectionItemPresenterToViewProtocol (Presenter -> View)
protocol CollectionItemPresenterToViewProtocol: AnyObject {
    func loadNewsData(data: News)
}

// MARK: CollectionItemRouterToViewProtocol (Router -> View)
protocol CollectionItemRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
    func popView()
}

class CollectionItemViewController: UIViewController {
    
    // MARK: - Property
    var presenter: CollectionItemViewToPresenterProtocol!
    
    private lazy var customController: CustomNavigationController = {
        let customController = CustomNavigationController(title: "Заголовок статьи", backButton: backNewsButton)
        customController.delegate = self
        
        return customController
    }()
    
    private lazy var backNewsButton: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        return button
    }()
    
    private lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 3
        return imageView
    }()
    
    private lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private lazy var newsСontent: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newsAutor: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var newsDate: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipesObservers()
        configureUI()
        presenter.viewDidLoad()
    }
    
    private func swipesObservers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipes(gester: UISwipeGestureRecognizer) {
        switch gester.direction {
        case .right:
            presenter.clickBackButton()
        default:
            break
        }
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(customController)
        customController.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.view.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(newsImage.snp.width).multipliedBy(0.56)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(customController.snp.bottom).inset(-10)
        }
        
        self.view.addSubview(newsTitle)
        newsTitle.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).inset(-10)
            make.left.right.equalTo(newsImage)
        }
        
        self.view.addSubview(newsСontent)
        newsСontent.snp.makeConstraints { make in
            make.top.equalTo(newsTitle.snp.bottom).inset(-20)
            make.left.right.equalTo(newsImage)
        }
        
        self.view.addSubview(newsAutor)
        newsAutor.snp.makeConstraints { make in
            make.top.equalTo(newsСontent.snp.bottom).inset(-30)
            make.left.right.equalTo(newsImage)
        }
        
        self.view.addSubview(newsDate)
        newsDate.snp.makeConstraints { make in
            make.top.equalTo(newsAutor.snp.bottom).inset(-5)
            make.left.right.equalTo(newsImage)
        }
    }
}

// MARK: CollectionItemPresenterToViewProtocol 
extension CollectionItemViewController: CollectionItemPresenterToViewProtocol{
    func loadNewsData(data: News) {
        if let newsImageUrl = data.image {
            self.newsImage.setImage(imageUrl: newsImageUrl)
        }
        
        if let title = data.title {
            self.customController.setTitle(title: title)
        }
        
        self.newsAutor.text = data.author
        self.newsDate.text = data.publishedAt
        self.newsTitle.text = data.title
        self.newsСontent.text = data.content
    }
}

// MARK: CollectionItemRouterToViewProtocol
extension CollectionItemViewController: CollectionItemRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension CollectionItemViewController: CustomNavigationControllerDelegate {
    func goToPreviousController() {
        presenter.clickBackButton()
    }
}
