//
//  RelatedUserCollectionView.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/18.
//

import UIKit
import Combine

class RelatedUserCollectionView: UIView {
    
    private weak var owner: APIHandler?
    
    var positionStatus: RelationPositionStatus?
    
    @Published var users: [User] = []
    
    private var registration: UICollectionView.CellRegistration<UserNameCell, Int>?
    
    private var collectionView: UICollectionView?
    
    private var cancellable: AnyCancellable?
    
    init(owner: APIHandler?, positionStatus: RelationPositionStatus) {
        self.owner = owner
        self.positionStatus = positionStatus
        super.init(frame: .zero)
        layout()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemenred")
    }
    
    private func layout() {
        let headerView = UIStackView()
        headerView.axis = .horizontal
        headerView.distribution = .equalSpacing
        headerView.alignment = .center
        
        self.addSubviewForAutoLayout(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            headerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14),
            headerView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.text = positionStatus?.string()
        
        let lookUpMoreButton = UIButton()
        let label = NSAttributedString(string: LabelDef.lookUpMore, attributes: [.font: UIFont.systemFont(ofSize: 12)])
        lookUpMoreButton.setAttributedTitle(label, for: .normal)
        lookUpMoreButton.setTitleColor(.blue, for: .normal)
        lookUpMoreButton.layer.borderWidth = 0
        
        headerView.addArrangedSubview(titleLabel)
        headerView.addArrangedSubview(lookUpMoreButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.registration = UICollectionView.CellRegistration<UserNameCell, Int> { [weak self] cell, _, itemIdentifier in
            guard let self = self, itemIdentifier < self.users.count else {
                return
            }
            cell.apiHandler = self.owner
            cell.user = self.users[itemIdentifier]
        }
        
        self.addSubviewForAutoLayout(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.collectionView = collectionView
    }
    
    private func subscribe() {
        cancellable = $users.sink { [weak self] _ in
            self?.collectionView?.reloadData()
        }
    }
}

extension RelatedUserCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let registration = self.registration else {
            return UICollectionViewCell()
        }
        return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: height * 0.83, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
}
