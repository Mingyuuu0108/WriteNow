//
//  model.swift
//  RealmApp
//
//  Created by 이민규 on 2022/11/21.
//

import RealmSwift

class userData: Object {
    @objc dynamic var userName:String = ""
}

class PostData: Object {
    @objc dynamic var content:String = ""
    @objc dynamic var emotion:String = ""
    @objc dynamic var date:String = ""
}
//class
