//
//  LoginTokenManager.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/20.
//

import Combine
import RealmSwift

class LoginTokenManager {
    
    static var loginTokenStored: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    private static let realm = try! Realm()
    
    static func storeToken(token: String) {
        let kv = realm.objects(DBKeyValue.self).where { $0.key == DBKeys.apiToken }.first
        if let kv = kv {
            try! realm.write {
                kv.value = token
            }
        } else {
            let newKv = DBKeyValue(key: DBKeys.apiToken, value: token)
            try! realm.write {
                realm.add(newKv)
            }
        }
        loginTokenStored.send(true)
    }
}
