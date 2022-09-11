//
//  MainViewController.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/08/30.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var label: UILabel?
    var iconStackView: UIStackView?

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutNavigationBar()
        layoutLabel()
        layoutIconStackView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func layoutNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationItem.title = "ホーム画面"
        let border = UIView()
        border.backgroundColor = .lightGray
        
        navigationBar.addSubviewForAutoLayout(border)
        
        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: 1),
            border.leftAnchor.constraint(equalTo: navigationBar.leftAnchor),
            border.rightAnchor.constraint(equalTo: navigationBar.rightAnchor),
            border.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
    }
    
    private func layoutLabel() {
        let label = UILabel()
        label.text = "Hello, World"
        label.textColor = .red
        label.textAlignment = .center
        
        view.addSubviewForAutoLayout(label)
        
        guard let height = navigationController?.navigationBar.frame.height else {
            return
        }
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: height + 50),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.label = label
    }
    
    private func layoutIconStackView() {
        let iconStackView = UIStackView()
        iconStackView.axis = .horizontal
        iconStackView.alignment = .center
        iconStackView.distribution = .fillEqually
        
        let label1 = UILabel.fontAwesome(type: .solid, name: "user", color: .black, size: 70)
        let label2 = UILabel.fontAwesome(type: .regular, name: "user", color: .black, size: 70)
        
        iconStackView.addArrangedSubview(label1)
        iconStackView.addArrangedSubview(label2)
        
        view.addSubviewForAutoLayout(iconStackView)
        
        guard let label = label else {
            return
        }
        
        NSLayoutConstraint.activate([
            iconStackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            iconStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            iconStackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        self.iconStackView = iconStackView
    }
}

