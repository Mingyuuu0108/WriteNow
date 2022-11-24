//
//  AppStepper.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/24.
//

import RxFlow
import RxCocoa
import RxSwift

class AppStepper: Stepper {
    
    var steps = PublishRelay<Step>()
    
    init() {}
    
    var initialStep: Step {
        return TestStep.writeEmotion
    }
}
