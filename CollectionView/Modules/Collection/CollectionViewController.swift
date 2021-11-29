//
//  CollectionViewController.swift
//  CollectionView
//
//  Created by Сергей Лукичев on 23.11.2021.
//  
//

import UIKit
import SnapKit

// MARK: CollectionPresenterToViewProtocol (Presenter -> View)
protocol CollectionPresenterToViewProtocol: AnyObject {
    func updateCollection(with data: [News])
}

// MARK: CollectionRouterToViewProtocol (Router -> View)
protocol CollectionRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class CollectionViewController: UIViewController {
    
    // MARK: - Property
    var presenter: CollectionViewToPresenterProtocol!
    
    private lazy var customController: CustomNavigationController = {
        let customController = CustomNavigationController(title: "News From Newsapi.org")
        return customController
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, News>(collectionView: collectionView) { collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.configure(withItemModel: item)
        return cell
    }

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
        
        self.view.addSubview(customController)
        customController.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(customController.snp.bottom)
        }
    }
}

// MARK: CollectionPresenterToViewProtocol 
extension CollectionViewController: CollectionPresenterToViewProtocol{
    func updateCollection(with data: [News]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, News>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
}

// MARK: CollectionRouterToViewProtocol
extension CollectionViewController: CollectionRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.clickOnItem(indexPath: indexPath)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let hightPerItem = widthPerItem / 100 * 56.25
        
        return CGSize(width: widthPerItem, height: hightPerItem)
    }
}
