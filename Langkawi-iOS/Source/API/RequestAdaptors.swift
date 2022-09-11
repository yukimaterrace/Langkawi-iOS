//
//  RequestAdaptors.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/11.
//

import Alamofire
import RealmSwift

class AuthorizationAdaptor: Adapter {
    
    static let shared = AuthorizationAdaptor()
    
    private static let authorization = "Authorization"
    private static let bearer = "Bearer"
    
    init() {
        let handler: (URLRequest, Session, _ completion: @escaping (Result<URLRequest, Error>) -> Void) -> Void = { (request, session, _) -> Void in
            var request = request
            let realm = try! Realm()
            let token = realm.objects(DBKeyValue.self).where { $0.key == DBKeys.apiToken }
            request.headers.add(name: AuthorizationAdaptor.authorization, value: "\(AuthorizationAdaptor.bearer) \(token)")
        }
        super.init(handler)
    }
}
