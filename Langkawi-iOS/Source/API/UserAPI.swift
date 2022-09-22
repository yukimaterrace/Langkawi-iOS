//
//  UserAPI.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/14.
//

import Combine

protocol UserAPI {
    
    func users(page: Int, pageSize: Int) -> AnyPublisher<UsersResponse, Error>
    
    func user(userId: Int) -> AnyPublisher<User, Error>
}

class UserAPIImpl: BaseAPI, UserAPI {
    
    func users(page: Int, pageSize: Int) -> AnyPublisher<UsersResponse, Error> {
        return getRequest(
            path: "/users",
            model: UsersResponse.self,
            parameters: ["page": page, "page_size": pageSize]
        )
    }
    
    func user(userId: Int) -> AnyPublisher<User, Error> {
        return getRequest(
            path: "/users/\(userId)",
            model: User.self
        )
    }
}
