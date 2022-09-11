//
//  LoginViewModel.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/11.
//

import Combine
import UIKit
import RealmSwift

class LoginViewModel: SwinjectSupport {
    
    lazy var loginAPI = resolveInstance(LoginAPI.self)
    
    func loginCompletion(response: LoginResponse) {
        let realm = try! Realm()
        let kv = realm.objects(DBKeyValue.self).where { $0.key == DBKeys.apiToken }.first
        if let kv = kv {
            kv.value = response.token
            return
        }
        
        let newKv = DBKeyValue(key: DBKeys.apiToken, value: response.token)
        try! realm.write {
            realm.add(newKv)
        }
    }
}
