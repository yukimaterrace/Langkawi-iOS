//
//  RelationStatus.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/18.
//

import Foundation

enum RelationStatus: String, Codable, CaseIterable {
    case pending
    case withdraw
    case accepted
    case declined
    case disconnected
    case refused
}
