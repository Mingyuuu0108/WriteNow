//
//  File.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/20.
//

import UIKit
import Then
import SnapKit
import RealmSwift

public var userName:String = ""

class MyPageVC: UIViewController, UITextFieldDelegate {
    
    private let backgound = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let GuideText = UILabel().then {
        $0.text = "환영해요!"
        $0.font = UIFont(name: "SDMiSaeng", size: 32)
        $0.textColor = .black
    }
    
    private let subText = UILabel().then {
        $0.text = "원하는 이름으로 마음껏 바꿀 수 있습니다!"
        $0.font = UIFont(name: "SDMiSaeng", size: 18)
        $0.textColor = .black
    }
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "원하는 이름을 입력해주세요."
        $0.font = UIFont(name: "SDMiSaeng", size: 28)
        $0.borderStyle = .none
    }
    
    private let textFieldBar = UIView().then {
        $0.backgroundColor = .placeholderText
    }
    
    private let nextButton = UIButton().then {
        $0.setTitle("바꾸기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.titleLabel?.textColor = .systemBackground
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .mainColor
        $0.addTarget(self, action: #selector(TabNextButton), for: .touchUpInside)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = nameTextField.text else {return false}
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        if text.count >= 8 {
            return false
        }
        
        return true
    }
    
    @objc func TabNextButton() {
        
        userName = nameTextField.text!
        
        if userName.count <= 1 {
            self.NoNameAlert()
        } else {
            self.CheckAlert()
        }
    }
    
    func NoNameAlert() {
        let alert = UIAlertController(title: "실패!", message: "이름을 작성해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    func CheckAlert() {
        let alert = UIAlertController(title: nil, message: "정말 \"\(userName)\"으로 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "네", style: .destructive, handler: {_ in
            self.addData()
            
            self.dismiss(animated: true) {
                
            } }))
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: {_ in print("") }))
        present(alert, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setup()
        nameTextField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        roadData()
    }
    
    func roadData() {
        
        let realm = try! Realm()
        
        let name = realm.objects(userData.self)
        for userData in name {
            let username = userData.userName
            GuideText.text = "\(username)님! 환영해요."
        }
    }
    
    func addData() {
        
        let realm = try! Realm()

        let result = userData()
        result.userName = userName
        
        try! realm.write {
            realm.add(result)
        }
    }
    
    func setup() {
        
        [
            backgound,
            GuideText,
            subText,
            nameTextField,
            textFieldBar,
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
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(subText.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(nameTextField.snp.top).offset(52)
        }
        
        textFieldBar.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(-8)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(textFieldBar.snp.top).offset(1)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(textFieldBar.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(nextButton.snp.top).offset(60)
        }
        
    }
}
