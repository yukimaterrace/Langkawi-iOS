//
//  APIHandler.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/11.
//

import UIKit
import Combine

protocol APIHandler {
    
    func request<T: Decodable>(
        errorHandler: ((Error) -> Bool)?,
        requester: () -> AnyPublisher<T, Error>?,
        handler: @escaping (T) -> Void
    ) -> AnyCancellable?
}

extension APIHandler where Self: UIViewController & SwinjectSupport {
    
    func request<T: Decodable>(
        errorHandler: ((Error) -> Bool)? = nil,
        requester: () -> AnyPublisher<T, Error>?,
        handler: @escaping (T) -> Void
    ) -> AnyCancellable? {
        let globalErrorHandler = self.resolveInstance(GlobalExceptionHandler.self)
        return requester()?.sink(receiveCompletion: { [weak self] in
            switch $0 {
            case .finished:
                break
            case .failure(let error):
                var cont = true
                if let errorHandler = errorHandler {
                    cont = errorHandler(error)
                }
                
                if cont {
                    globalErrorHandler.handle(error: error, vc: self)
                }
            }
        }, receiveValue: handler)
    }
}
