//
//  AppFlow.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/24.
//

import RxFlow

class AppFlow: Flow {
    
    let window: UIWindow!
  
    init(window: UIWindow) {
        self.window = window
    }
    
    var root: Presentable {
        return self.window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        
        guard let step = step as? TestStep else { return .none }
        
        switch step {
        case.writeEmotion:
            return self.navigateToWriteFlow()
        }
    }
    
    private func navigateToWriteFlow() -> FlowContributors {
        let viewModel = AppStepper()
        let mainFlow = MainFlow(viewModel: viewModel)
        Flows.use(mainFlow, when: .created) { root in
            self.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: viewModel))
    }
}
