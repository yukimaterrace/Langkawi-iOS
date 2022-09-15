//
//  UseEffectSupport.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/15.
//

import Foundation
import Combine

class UseEffectSupportInjector: LifecycleInjector {
    private let effector: () -> AnyCancellable?
    private var cancellable: AnyCancellable?
    
    init(effector: @escaping () -> AnyCancellable?) {
        self.effector = effector
    }
    
    func onViewWillAppear() {
        cancellable = effector()
    }
    
    func onViewDidDisappear() {
        cancellable?.cancel()
    }
}

protocol UseEffectSupport: LifecycleInjectableViewController {}

extension UseEffectSupport {
    
    func useEffect(_ effector: @escaping () -> AnyCancellable?) {
        let injector = UseEffectSupportInjector(effector: effector)
        registerLifecycleInjector(injector: injector)
    }
}
