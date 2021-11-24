//
//  CollectionItemViewController.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 24.11.2021.
//  
//

import UIKit

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
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(backButtonSubmit), for: .touchUpInside)
        return button
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

        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        self.view.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(newsImage.snp.width).multipliedBy(0.56)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(backButton.snp.bottom)
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
    
    @objc private func backButtonSubmit() {
        presenter.clickBackButton()
    }
}

// MARK: CollectionItemPresenterToViewProtocol 
extension CollectionItemViewController: CollectionItemPresenterToViewProtocol{
    func loadNewsData(data: News) {
        print(data)
        if let newsImageUrl = data.image {
            self.newsImage.setImage(imageUrl: newsImageUrl)
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
