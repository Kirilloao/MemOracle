//
//  SceneDelegate.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        let mainVC = MainViewController()
//        let listVC = ListViewController()
        let tabBarVC = TabBarController()
                
//        tabBarVC.setViewControllers([mainVC, listVC], animated: true)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        

    }
}

