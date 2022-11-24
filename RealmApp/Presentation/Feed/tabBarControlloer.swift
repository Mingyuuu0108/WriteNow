//
//  tabBarControlloer.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/23.
//

import UIKit
import RxFlow
import RxCocoa

class tabBarController: UITabBarController, Stepper {
    
    var steps = PublishRelay<Step>()
    
    private let addButton = UIButton().then {
        $0.setImage(UIImage(named: "tabBaraddcircle"), for: .normal)
        $0.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }
    
    private let tabBarLineView = UIView().then {
        $0.backgroundColor = UIColor(white: 0, alpha: 0.1)
    }
    
    @objc func nextPage() {
        let vc = WriteEmotionVC()
        self.navigationController?.pushViewController(vc, animated: true)
//        self.steps.accept(TestStep.writeEmotion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem()
        
    }
    
    func tabBarItem() {
        
        [
            tabBarLineView,
            addButton
        ].forEach { self.view.addSubview($0) }
        
        let background = UIImageView(image: UIImage(named: "background"))
        background.frame = self.tabBar.bounds
        self.tabBar.addSubview(background)
        self.tabBar.sendSubviewToBack(background)
        
        let firstVC = UINavigationController(rootViewController: FeedVC())
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let dummyView = UINavigationController(rootViewController: MyPageVC())
        dummyView.tabBarItem.image = UIImage(systemName: "person")
        dummyView.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        viewControllers = [firstVC, dummyView]
        
        tabBarLineView.snp.makeConstraints {
            $0.top.equalTo(tabBarLineView.snp.bottom).offset(-1)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(tabBar.snp.top)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.top).offset(-30)
            $0.center.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
        
    }
}
