//
//  LoginViewController.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/04.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    private func layout() {
        let container = UIView()
        
        let loginIdTextField = createTextField(placeHolder: LabelDef.loginID, isSecureText: false)
        let passwordTextField = createTextField(placeHolder: LabelDef.password, isSecureText: true)
        let button = createLoginButton()
        
        container.addSubviewForAutoLayout(loginIdTextField)
        container.addSubviewForAutoLayout(passwordTextField)
        container.addSubviewForAutoLayout(button)
        
        NSLayoutConstraint.activate([
            loginIdTextField.topAnchor.constraint(equalTo: container.topAnchor),
            loginIdTextField.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20),
            loginIdTextField.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20),
            loginIdTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginIdTextField.bottomAnchor, constant: 30),
            passwordTextField.leftAnchor.constraint(equalTo: loginIdTextField.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: loginIdTextField.rightAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginIdTextField.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            button.widthAnchor.constraint(equalToConstant: 240),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        
        view.addSubviewForAutoLayout(container)
        
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func createTextField(placeHolder: String, isSecureText: Bool) -> UITextField {
        let textField = ProjectTextField()
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.placeholder = placeHolder
        textField.isSecureTextEntry = isSecureText
        textField.clearButtonMode = .always
        textField.keyboardType = .default
        textField.delegate = self
        return textField
    }
    
    private func createLoginButton() -> UIButton {
        let button = UIButton()
        let titleAttr: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        let title = NSAttributedString(string: LabelDef.login, attributes: titleAttr)
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(self.onClickButton(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func onClickButton(_ sender: UIButton) {
        print("tapped")
    }
}
