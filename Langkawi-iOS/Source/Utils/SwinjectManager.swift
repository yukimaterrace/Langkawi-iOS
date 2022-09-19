//
//  SwinjectManager.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/03.
//

import Swinject

class SwinjectManager {
    
    static let shared: SwinjectManager = SwinjectManager()
    
    let container = Container()
    
    func initialize() {
        container.register(GlobalExceptionHandler.self) { _ in GlobalExceptionHandler() }
        container.register(LoginAPI.self) { _ in LoginAPIImpl() }
        container.register(UserAPI.self) { _ in UserAPIImpl() }
        container.register(ImageAPI.self) { _ in ImageAPIImpl() }
        container.register(RelationAPI.self) { _ in RelationAPIImpl() }
    }
}

protocol SwinjectSupport {}

extension SwinjectSupport {
    
    func resolveInstance<T>(_ type: T.Type) -> T {
        return SwinjectManager.shared.container.resolve(type)!
    }
}
