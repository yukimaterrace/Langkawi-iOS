//
//  HomeViewModel.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/18.
//

import Combine

class HomeViewModel {
    private lazy var relationApi = owner?.resolveInstance(RelationAPI.self)
    
    private weak var owner: HomeViewController?
    
    private var users: [User] = []
    
    init(owner: HomeViewController) {
        self.owner = owner
    }
    
    func setup() {
        owner?.relatedUserCollectionViews.forEach { [weak self] view in
            self?.owner?.useEffect(dependencies: [
                owner?.eventSubject.map { _ in true }.eraseToAnyPublisher()
            ].compactMap { $0 }) { [weak self] in
                self?.fetch(view: view)
            }
        }
    }
    
    private func fetch(size: Int = 8, view: RelatedUserCollectionView) -> AnyCancellable? {
        return owner?.request(requester: { [weak self] () -> AnyPublisher<RelationsResponse, Error>? in
            guard let positionStatus = view.positionStatus else {
                return nil
            }
            return self?.relationApi?.relations(page: 0, pageSize: size, positionStatus: positionStatus)
        }) {
            view.users = $0.list.map { $0.user }
        }
    }
}
