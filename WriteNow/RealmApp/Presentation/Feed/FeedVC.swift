//
//  File.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/21.
//

import UIKit
import Then
import SnapKit
import RealmSwift

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var postData:[PostData] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if postData.count <= 20 {
            return postData.count
        } else { return 20 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.selectionStyle = .none
        
        let date = self.postData[indexPath.row].date
        let emotion = self.postData[indexPath.row].emotion
        let content = self.postData[indexPath.row].content
        cell.dateAndEmotionText.text = "\(date) · \(emotion)"
        cell.content.text = content
        
        return cell
    }
    
    private let backgound = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    private let lineView = UIView().then {
//        $0.backgroundColor = UIColor(white: 0, alpha: 0.1)
//    }
    
    lazy var tableView = UITableView().then {
        $0.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.rowHeight = 85
    }
    
    func roadData() {
        let realm = try! Realm()
        let result = realm.objects(PostData.self)
        self.postData = Array(result)
        self.postData.reverse()/// 배열을 더욱 잘 뒤집을 방법 찾아보기
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
//        realmRead()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        roadData()

    }
    
    func setup() {
        
        [
            backgound,
            tableView
        ].forEach { self.view.addSubview($0) }
        
        backgound.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
//        lineView.snp.makeConstraints {
//            $0.top.equalTo(lineView.snp.bottom).offset(-1)
//            $0.left.equalToSuperview()
//            $0.right.equalToSuperview()
//            $0.bottom.equalTo(tableView.snp.top)
//        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-80)
        }
    }
    
}
