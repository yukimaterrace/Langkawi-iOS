//
//  HomeViewController.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/08/30.
//

import UIKit
import Combine

class HomeViewController: BaseViewController, DialogPresenterSupport {
    private lazy var vm = HomeViewModel(owner: self)
    
    var eventSubject: PassthroughSubject<DialogEvent, Never> = PassthroughSubject()
    
    var relatedUserCollectionViews: [RelatedUserCollectionView] = []
    
    private var containerView: UIView?
    
    override func viewDidLoad() {
        layoutNavigationBar()
        layout()
        
        vm.setup()
        super.viewDidLoad()
    }
    
    private func layoutNavigationBar() {
        navigationItem.title = LabelDef.home
        layoutNavigationBarBorder()
    }
    
    private func layout() {
        let collectionViewHeight: CGFloat = 136
        let verticalMargin: CGFloat = 30
        
        relatedUserCollectionViews = RelationPositionStatus.allCases.map { [weak self] in
            RelatedUserCollectionView(owner: self, positionStatus: $0)
        }
        
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        
        view.addSubviewForAutoLayout(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let container = UIView()
        scrollView.addSubviewForAutoLayout(container)
        
        let height = collectionViewHeight + verticalMargin
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            container.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.heightAnchor.constraint(equalToConstant: height * CGFloat(relatedUserCollectionViews.count))
        ])
        
        self.containerView = container
        
        var anchor = container.topAnchor
        relatedUserCollectionViews.forEach {
            container.addSubviewForAutoLayout($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: anchor, constant: verticalMargin),
                $0.leftAnchor.constraint(equalTo: container.leftAnchor),
                $0.rightAnchor.constraint(equalTo: container.rightAnchor),
                $0.heightAnchor.constraint(equalToConstant: collectionViewHeight)
            ])
            anchor = $0.bottomAnchor
        }
    }
}

