//
//  File.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/21.
//

import UIKit
import Then
import SnapKit

public var userPassword:String = ""

class InputPasswordVC: UIViewController {
    
    private let GuideText = UILabel().then {
        $0.text = "비밀번호을 입력해주세요!"
        $0.font = .systemFont(ofSize: 26, weight: .bold)
        $0.textColor = .black
    }
    
    private let subText = UILabel().then {
        $0.text = "비밀번호를 통해 나만의 비밀 라잇나우가 될 수 있어요."
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .black
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "4~6자리의 숫자로 입력해주세요."
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.borderStyle = .none
    }
    
    private let textFieldBar = UIView().then {
        $0.backgroundColor = .placeholderText
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
        
        userPassword = passwordTextField.text!
        let rootVC = ReInputPasswordVC()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setup()
    }
    
    func setup() {
        
        [   GuideText,
            subText,
            passwordTextField,
            textFieldBar,
            nextButton
        ].forEach{ self.view.addSubview($0) }
        
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
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(subText.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(passwordTextField.snp.top).offset(52)
        }
        
        textFieldBar.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(textFieldBar.snp.top).offset(1)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(-60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
    }
}
