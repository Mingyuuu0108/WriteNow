//
//  WriteVC.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/21.
//

import UIKit
import Then
import SnapKit
import RealmSwift

class WriteEmotionVC: UIViewController {
    
    private let backButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(doWrite))
    
    private let backgound = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let emotionText = UILabel().then {
        $0.text = "당신은 지금 어떠신가요?"
        $0.font = UIFont(name: "SDMiSaeng", size: 36)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let emotionImage = UIImageView().then {
        $0.image = UIImage(named: "addcircle")
    }
    
    private let guiedText = UILabel().then {
        $0.text = "이제 감정을 글로 적어봐요."
        $0.font = UIFont(name: "SDMiSaeng", size: 20)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let textNum = UILabel().then {
        $0.text = "0/200"
        $0.font = UIFont(name: "SDMiSaeng", size: 26)
        $0.textColor = UIColor(white: 0, alpha: 0.3)
        $0.textAlignment = .right
    }
    
    private let emotionTextView = UITextView().then {
        $0.text =  "왜 그 감정을 느꼈는 지 적어주세요."
        $0.textColor = UIColor(white: 0, alpha: 0.3)
        $0.font = UIFont(name:"SDMiSaeng" , size: 26)
        $0.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.7)
        $0.layer.cornerRadius = 12
//        $0.isScrollEnabled = false
    }
    
    @objc func doWrite() {
        
        let rootVC = WriteCheckVC()
        rootVC.content = emotionTextView.text!
        rootVC.modalPresentationStyle = .fullScreen
        self.present(rootVC, animated: false, completion: nil)
    }
    
    private func realmRead() {
        let realm = try! Realm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let name = realm.objects(userData.self)
        for userData in name {
            let username = userData.userName
            emotionText.text = "\(username)님은 지금 어떠신가요?"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if emotionTextView.text.count > 200 {
            emotionTextView.deleteBackward()
        }
        
        textNum.text = "\(emotionTextView.text.count)/200"
        
        let attributedString = NSMutableAttributedString(string: "\(emotionTextView.text.count)/200")
        attributedString.addAttribute(.foregroundColor, value: UIColor.mainColor as Any, range: ("\(emotionTextView.text.count)/200" as NSString).range(of:"\(emotionTextView.text.count)"))
        textNum.attributedText = attributedString
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmRead()
        emotionTextView.delegate = self
        
        view.backgroundColor = .systemBackground
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emotionText.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func setup() {
        
        navigationItem.rightBarButtonItem = self.backButton
        [
            backgound,
            emotionText,
            emotionImage,
            guiedText,
            emotionTextView,
            textNum
        ].forEach { self.view.addSubview($0) }
        
        backgound.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        emotionText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(emotionText.snp.top).offset(30)
        }
        
        emotionImage.snp.makeConstraints {
            $0.top.equalTo(emotionText.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(160)
            $0.right.equalToSuperview().offset(-160)
            $0.bottom.equalTo(emotionImage.snp.top).offset(70)
        }
        
        guiedText.snp.makeConstraints {
            $0.top.equalTo(emotionImage.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(100)
            $0.right.equalToSuperview().offset(-100)
            $0.bottom.equalTo(guiedText.snp.top).offset(20)
        }
        
        emotionTextView.snp.makeConstraints {
            $0.top.equalTo(guiedText.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(emotionTextView.snp.top).offset(120)
        }
        
        textNum.snp.makeConstraints {
            $0.top.equalTo(emotionTextView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(textNum.snp.top).offset(28)
        }
    }
    
}

extension WriteEmotionVC: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if emotionTextView.text.isEmpty {
            emotionTextView.textColor = UIColor(white: 0, alpha: 0.3)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if emotionTextView.textColor == UIColor(white: 0, alpha: 0.3) {
            emotionTextView.text = nil
            emotionTextView.textColor = UIColor.black
        }
    }
    
}
