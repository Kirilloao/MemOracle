//
//  TabBarController.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    // MARK: - Private Methods
    private func setupControllers() {
        let firstVC = MainViewController()
        let firstNavVC = UINavigationController(rootViewController: firstVC)
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondVC = ListViewController()
        let secondNavVC = UINavigationController(rootViewController: secondVC)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        tabBar.tintColor = .systemBlue
        self.viewControllers = [firstNavVC, secondNavVC]
    }

}
