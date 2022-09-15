//
//  FindViewController.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/14.
//

import Foundation
import UIKit
import Combine
import Alamofire

class FindViewController: BaseViewController, DialogPresenterSupport {
    private lazy var vm = FindViewModel(owner: self) { [weak self] in
        self?.collectionView?.reloadData()
    }
    
    private var cellRegistration: UICollectionView.CellRegistration<UserCellView, Int>?
    
    private var collectionView: UICollectionView?
    
    internal var eventSubject: PassthroughSubject<DialogEvent, Never> = PassthroughSubject()
    
    override func viewDidLoad() {
        vm.setup()
        
        super.viewDidLoad()
        layoutNavigationBar()
        layout()
    }
    
    private func layoutNavigationBar() {
        navigationItem.title = LabelDef.find
        layoutNavigationBarBorder()
    }
    
    private func layout() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cellRegistration = UICollectionView.CellRegistration<UserCellView, Int> { [weak self] cell, _, itemIdentifier in
            cell.apiHandler = self
            cell.user = self?.vm.resolveUser(index: itemIdentifier)
        }
        
        view.addSubviewForAutoLayout(collectionView)
        
        guard let height = navigationController?.navigationBar.bounds.height else {
            return
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: height + 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        self.collectionView = collectionView
    }
}

extension FindViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.resolveCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellRegistration = cellRegistration else {
            return UICollectionViewCell()
        }

        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 3
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TODO: fetch another page
    }
}
