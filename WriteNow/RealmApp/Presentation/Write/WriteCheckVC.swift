//
//  WriteCheckVC.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/22.
//

import UIKit
import Then
import SnapKit
import RealmSwift

class WriteCheckVC: UIViewController {
    
    var content:String = ""
    var date:String = ""

    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let emotionText = UILabel().then {
        $0.text = "당신은 지금 설레요!"
        $0.font = UIFont(name: "SDMiSaeng", size: 32)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let emotionImage = UIImageView().then {
        $0.image = UIImage(named: "addcircle")
    }
    
    private let dateText = UILabel().then {
        $0.text = "2022.12.25"
        $0.font = UIFont(name: "SDMiSaeng", size: 20)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let contentText = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "SDMiSaeng", size: 24)
        $0.numberOfLines = 3
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let saveQestionText = UILabel().then {
        $0.text = "저장하시겠습니까?"
        $0.font = UIFont(name: "SDMiSaeng", size: 32)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.distribution = .fillEqually
        $0.spacing = 30
    }
    
    private let backButton = UIButton().then {
        $0.setTitle("돌아가기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "SDMiSaeng", size: 30)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainColor?.cgColor
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    private let saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "SDMiSaeng", size: 30)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .mainColor
        $0.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    @objc func back() {
        self.dismiss(animated: false)
        print("돌아가기")
    }
    
    @objc func save() {
        print("저장하기")
        addData()
        self.dismiss(animated: false)
    }
    
    func addData() {
        
        let realm = try! Realm()
        
        let data = PostData()
        data.content = content
        data.date = date
        data.emotion = "기뻐요!"
        
        try! realm.write {
            realm.add(data)
        }
    }
    
    func NowTime() -> String {
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        return dateFormatter.string(from: now)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setup()
        self.contentText.text = content
        self.dateText.text = NowTime()
        date = NowTime()
        print(content)
    }
    
    func setup() {
        
        [
            backButton,
            saveButton
        ].forEach { self.stackView.addArrangedSubview($0) }
        
        [
            background,
            emotionText,
            emotionImage,
            dateText,
            contentText,
            saveQestionText,
            stackView
        ].forEach { self.view.addSubview($0) }
        
        background.snp.makeConstraints { /// 나중에 바꿉시당
            $0.top.equalToSuperview().offset(180)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-240)
        }
        
        emotionText.snp.makeConstraints {
            $0.top.equalTo(background.snp.top).offset(20)
            $0.left.equalTo(background.snp.left)
            $0.right.equalTo(background.snp.right)
            $0.bottom.equalTo(emotionText.snp.top).offset(30)
        }
        
        emotionImage.snp.makeConstraints {
            $0.top.equalTo(emotionText.snp.bottom).offset(16)
            $0.left.equalTo(background.snp.left).offset(140)
            $0.right.equalTo(background.snp.right).offset(-140)
            $0.bottom.equalTo(emotionImage.snp.top).offset(70)
        }
        
        dateText.snp.makeConstraints {
            $0.top.equalTo(emotionImage.snp.bottom).offset(10)
            $0.left.equalTo(background.snp.left).offset(80)
            $0.right.equalTo(background.snp.right).offset(-80)
            $0.bottom.equalTo(dateText.snp.top).offset(20)
        }
        
        contentText.snp.makeConstraints {
            $0.top.equalTo(dateText.snp.bottom).offset(20)
            $0.left.equalTo(background.snp.left).offset(40)
            $0.right.equalTo(background.snp.right).offset(-40)
            $0.bottom.equalTo(contentText.snp.top).offset(80)
        }
        
        saveQestionText.snp.makeConstraints {
            $0.top.equalTo(saveQestionText.snp.bottom).offset(-30)
            $0.left.equalTo(background.snp.left).offset(40)
            $0.right.equalTo(background.snp.right).offset(-40)
            $0.bottom.equalTo(stackView.snp.top).offset(-20)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(-40)
            $0.left.equalTo(background.snp.left).offset(40)
            $0.right.equalTo(background.snp.right).offset(-40)
            $0.bottom.equalTo(background.snp.bottom).offset(-30)
        }
    }
}
