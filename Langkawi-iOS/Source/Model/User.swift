//
//  User.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/14.
//

import Foundation

struct User: Codable {
    let id: Int
    let userType: UserType
    let firstName: String?
    let lastName: String?
    let gender: GenderType?
    let age: Int?
    let accountId: Int
    let detail: UserDetail?
    let createdAt: Date
    let updatedAt: Date
}

extension User {
    func toNameLabelText() -> String {
        return "\(self.lastName ?? "") \(self.firstName ?? "")"
    }
    
    func toAgeLabelText() -> String {
        return "\(self.age ?? 0)\(LabelDef.ageSuffix)"
    }
}
