//
//  DialogManager.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/03.
//

import Foundation
import UIKit

class DialogManager {
    
    static func showAlert(vc: UIViewController?, title: String?, message: String?) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default))
        vc?.present(dialog, animated: false, completion: nil)
    }
}
