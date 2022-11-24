//
//  AppFlow.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/24.
//

import RxFlow

class AppFlow: Flow {
    
    var rootVC = UINavigationController()

    var root: RxFlow.Presentable {
        return self.rootVC
    }
    
    init(rootVC: UINavigationController) {
        self.rootVC = rootVC
    }
    
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        
        guard let step = step as? TestStep else { return .none }
        
        switch step {
        case.writeEmotion:
            return self.navigateToWrite()
        case.checkEmotion:
            return self.navigateToCheck()
        }
    }
    
    
}
