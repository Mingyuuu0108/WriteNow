//
//  TabBarController.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/23.
//

import UIKit
import Then

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabBar.backgroundColor = .systemBackground
        
        let FeedView = UINavigationController(rootViewController: FeedVC())
        FeedView.tabBarItem.title = "홈화면"
        FeedView.tabBarItem.image = UIImage(systemName: "house")
        FeedView.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let ChoiceEmotionView = UINavigationController(rootViewController: ChoiceEmotionVC())
        ChoiceEmotionView.tabBarItem.title = "글쓰기"
        ChoiceEmotionView.tabBarItem.image = UIImage(systemName: "plus.circle")
        ChoiceEmotionView.tabBarItem.selectedImage = UIImage(systemName: "plus.circle.fill")
        
        let WelcomeView = UINavigationController(rootViewController: UIViewController())
        WelcomeView.tabBarItem.title = "마이페이지"
        WelcomeView.tabBarItem.image = UIImage(systemName: "person")
        WelcomeView.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        viewControllers = [FeedView, ChoiceEmotionView, WelcomeView]
    }
}

