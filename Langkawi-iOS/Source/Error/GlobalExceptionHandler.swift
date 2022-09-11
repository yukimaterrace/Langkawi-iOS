//
//  GlobalExceptionHandler.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/03.
//

import Alamofire

class GlobalExceptionHandler {
    
    func handle(error: Error, vc: UIViewController?) {
        var title: String?
        let message: String?
        switch error {
        case let err as APIStatusError:
            title = err.response.error
            message = err.response.exception
        case let err as AFError:
            message = err.localizedDescription
        default:
            message = error.localizedDescription
        }
        
        DialogManager.showAlert(vc: vc, title: title, message: message)
    }
}
