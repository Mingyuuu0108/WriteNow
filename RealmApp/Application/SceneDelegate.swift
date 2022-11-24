//
//  SceneDelegate.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/20.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController: tabBarController())
//        window?.rootViewController = UINavigationController(rootViewController: WelcomePageVC())

        window?.makeKeyAndVisible()
        window?.tintColor = .mainColor
    }
    
    //    func sceneDidDisconnect(_ scene: UIScene) {
    //    }
    //
    //    func sceneDidBecomeActive(_ scene: UIScene) {
    //    }
    //
    //    func sceneWillResignActive(_ scene: UIScene) {
    //    }
    //
    //    func sceneWillEnterForeground(_ scene: UIScene) {
    //    }
    //
    //    func sceneDidEnterBackground(_ scene: UIScene) {
    //    }
    
}

