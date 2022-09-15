//
//  MainTabBarController.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/12.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        layoutTabBar()
    }
    
    private func setupViewControllers() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(
            title: LabelDef.home,
            image: homeTabBarItemImage(color: .black),
            selectedImage: homeTabBarItemImage(color: .blue)
        )
        
        let findViewController = UINavigationController(rootViewController: FindViewController())
        findViewController.tabBarItem = UITabBarItem(
            title: LabelDef.find,
            image: findTabBarItemImage(color: .black),
            selectedImage: findTabBarItemImage(color: .blue)
        )
        
        let accountViewController = HomeViewController()
        accountViewController.tabBarItem = UITabBarItem(
            title: LabelDef.account,
            image: accountTabBarItemImage(color: .black),
            selectedImage: accountTabBarItemImage(color: .blue)
        )
        
        viewControllers = [
            homeViewController,
            findViewController,
            accountViewController
        ]
    }
    
    private func layoutTabBar() {
        let border = UIView()
        border.backgroundColor = .lightGray
        
        tabBar.addSubviewForAutoLayout(border)
        
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: tabBar.topAnchor),
            border.leftAnchor.constraint(equalTo: tabBar.leftAnchor),
            border.rightAnchor.constraint(equalTo: tabBar.rightAnchor),
            border.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func tabBarItemImage(name: String, color: UIColor) -> UIImage? {
        let size: CGFloat = 20
        let label = UILabel.fontAwesome(type: .solid, name: name, color: color, size: size)
        label.bounds.size = CGSize(width: size+5, height: size)
        return label.toImage()
    }
    
    private func homeTabBarItemImage(color: UIColor) -> UIImage? {
        return tabBarItemImage(name: "house", color: color)
    }
    
    private func findTabBarItemImage(color: UIColor) -> UIImage? {
        return tabBarItemImage(name: "magnifying-glass", color: color)
    }
    
    private func accountTabBarItemImage(color: UIColor) -> UIImage? {
        return tabBarItemImage(name: "user", color: color)
    }
}
