//
//  GenderType.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/14.
//

import Foundation

enum GenderType: String, Codable {
    case male
    case female
    
    func toLabel() -> String {
        switch self {
        case .male:
            return LabelDef.male
        case .female:
            return LabelDef.female
        }
    }
}
