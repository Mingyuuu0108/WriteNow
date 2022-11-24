//
//  WriteVC.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/21.
//

import UIKit
import Then
import RealmSwift
import SnapKit
import FlexLayout
import PinLayout

class WriteEmotionVC: UIViewController {
    
    private let backButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(doWrite))
    
    private let rootContainer = UIImageView().then {
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
    
    private let emotionTextView = UITextView().then {
        $0.text =  "왜 그 감정을 느꼈는 지 적어주세요."
        $0.textColor = UIColor(white: 0, alpha: 0.3)
        $0.font = UIFont(name:"SDMiSaeng" , size: 26)
        $0.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.7)
        $0.layer.cornerRadius = 12
        $0.isEditable = true
    }
    
    private let textNum = UILabel().then {
        $0.text = "0/200"
        $0.font = UIFont(name: "SDMiSaeng", size: 26)
        $0.textColor = UIColor(white: 0, alpha: 0.3)
        $0.textAlignment = .right
    }
    
    @objc func doWrite() {
        
        let rootVC = CheckEmotion()
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
        setup()

        view.backgroundColor = .systemBackground
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emotionText.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootContainer.pin.all()
        rootContainer.flex.layout()
        
    }
    
    func setup() {
        
        navigationItem.rightBarButtonItem = self.backButton
        
        view.addSubview(rootContainer)
        
        rootContainer.flex.direction(.column).define { flex in
            flex.addItem(emotionText)
                .marginTop(100)
            flex.addItem(emotionImage)
                .marginTop(16)
                .marginLeft(160)
                .marginRight(160)
            flex.addItem(guiedText)
                .marginTop(16)
            flex.addItem(emotionTextView)
                .marginLeft(20)
                .marginRight(20)
                .paddingBottom(120)
            flex.addItem(textNum)
                .marginRight(20)
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
