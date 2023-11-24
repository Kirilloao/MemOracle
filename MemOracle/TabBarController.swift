//
//  TabBarController.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
    }
    
    private func setupControllers() {
        let firstVC = MainViewController()
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondVC = ListViewController()
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        tabBar.tintColor = .systemBlue
        self.viewControllers = [firstVC, secondVC]
    }

}
