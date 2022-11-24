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

class ChoiceEmotionVC: UIViewController {
    
    private let backgound = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let nextButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowcircle"), for: .normal)
        $0.addTarget(self, action: #selector(NextPage), for: .touchUpInside)
    }
    
    @objc func NextPage() {
        let rootVC = WriteCheckVC()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setup()
    }
    
    func setup() {
        [
            backgound,
            nextButton
        ].forEach { self.view.addSubview($0) }
        
        backgound.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(-64)
            $0.left.equalToSuperview().offset(160)
            $0.right.equalToSuperview().offset(-160)
            $0.bottom.equalToSuperview().offset(-60)
        }
        
    }
    
}
