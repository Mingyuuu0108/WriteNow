//
//  File.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/20.
//

import UIKit
import Then
import SnapKit

class SecondIntroPage: UIViewController {
    
    private let backgound = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let GuideText = UILabel().then {
        $0.text = "당신이 적었던 감정들을 다시 읽어봐요."
        $0.font = UIFont(name: "SDMiSaeng", size: 32)
        $0.textColor = .black
    }
    
    private let subText = UILabel().then {
        $0.text = "자신이 어떤 감정을 주로 느끼는지 어떻게 해결했는지 알게되어요."
        $0.font = UIFont(name: "SDMiSaeng", size: 18)
        $0.textColor = .black
    }
    
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.titleLabel?.textColor = .systemBackground
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .mainColor
        $0.addTarget(self, action: #selector(TabNextButton), for: .touchUpInside)
    }
    
    @objc func TabNextButton() {
        
        let rootVC = InputNameVC()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemBackground
        setup()
    }
    
    func setup() {
        
        [
            backgound,
            GuideText,
            subText,
            nextButton
        ].forEach{ self.view.addSubview($0) }
        
        backgound.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        GuideText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(GuideText.snp.top).offset(26)
        }
        
        subText.snp.makeConstraints {
            $0.top.equalTo(GuideText.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(subText.snp.top).offset(14)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(-60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
    }
}
