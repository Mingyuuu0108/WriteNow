//
//  MainFlow.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/24.
//
import RxFlow

class MainFlow: Flow {
    
    let navigationController = UINavigationController()
    
    let viewModel: AppStepper
    
    init(viewModel: AppStepper) {
        self.viewModel = viewModel
    }
    
    var root: Presentable {
        return self.navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TestStep else { return .none }
        switch step {
        case .writeEmotion:
            return presentWriteEmotionVC()
            
        }
    }
    
    private func presentWriteEmotionVC() -> FlowContributors {
        let vc = WriteEmotionVC()
        self.navigationController.pushViewController(vc, animated: true)
        
        return .none
    }
    
}
