//
//  FindViewModel.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/14.
//

import Combine
import UIKit

class FindViewModel: SwinjectSupport {
    typealias Owner = UseEffectSupport & APIHandler & DialogPresenterSupport
    
    private lazy var userApi = resolveInstance(UserAPI.self)
    private lazy var imageApi = resolveInstance(ImageAPI.self)
    
    private weak var owner: Owner?
    private let onFetchCompletion: () -> Void
    
    var cancellables: Set<AnyCancellable> = []
    
    private var users: [User] = []
    
    init(owner: Owner, onFetchCompletion: @escaping () -> Void) {
        self.owner = owner
        self.onFetchCompletion = onFetchCompletion
    }
    
    func setup() {
        owner?.useDialogPresenterSupport { [weak self] _ in
            guard let self = self else { return }
            self.fetch(page: 0)?.store(in: &self.cancellables)
        }
        owner?.useEffect { [weak self] in
            self?.fetch(page: 0)
        }
    }
    
    func fetch(page: Int, pageSize: Int = 100) -> AnyCancellable? {
        return owner?.request(requester: { [weak self] in
            self?.userApi.users(page: page, pageSize: pageSize)
        }) { [weak self] in
            self?.users = $0.list
            self?.onFetchCompletion()
        }
    }
    
    func resolveUser(index: Int) -> User? {
        guard index < users.count else {
            return nil
        }
        return users[index]
    }
    
    func resolveCount() -> Int {
        return users.count
    }
}
