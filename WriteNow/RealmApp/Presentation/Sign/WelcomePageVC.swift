//
//  File.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/20.
//

import UIKit
import Then
import SnapKit

class WelcomePageVC: UIViewController {
    
    private let backgound = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let welcomeText = UILabel().then {
        $0.text = "라잇나우에 처음 오신 걸 환영해요!"
        $0.font = UIFont(name: "SDMiSaeng", size: 32)
        $0.textColor = .black
    }
    
    private let subText = UILabel().then {
        $0.text = "라잇나우에 대해 간단히 알아보고 바로 시작해보아요."
        $0.font = UIFont(name: "SDMiSaeng", size: 18)
        $0.textColor = .black
    }
    
    private let signUpButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.titleLabel?.textColor = .systemBackground
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .mainColor
        $0.addTarget(self, action: #selector(TabSignUpButton), for: .touchUpInside)
    }
    
    @objc func TabSignUpButton() {
        let rootVC = FirstIntroPage()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setup()
    }
    
    func setup() {
        
        [
            backgound,
            welcomeText,
            subText,
            signUpButton
        ].forEach{ self.view.addSubview($0) }
        
        backgound.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        welcomeText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(welcomeText.snp.top).offset(26)
        }
        
        subText.snp.makeConstraints {
            $0.top.equalTo(welcomeText.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(subText.snp.top).offset(14)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(-60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
    }
}
