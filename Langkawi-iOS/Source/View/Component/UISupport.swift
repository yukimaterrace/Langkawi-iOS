//
//  UISupport.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/04.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviewForAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
}
