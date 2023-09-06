//
//  RealmRepository.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/09/06.
//

import Foundation
import Realm
import RealmSwift

protocol RealmRepository {
    func saveData(realmObject: RealmSwiftObject)
    func fetchSavedData<T: RealmSwiftObject>(type: T.Type) -> Results<T>
}

class DefaultRealmRepository: RealmRepository {
    
    let realm = try! Realm()
    
    func saveData(realmObject: RealmSwiftObject) {
        try! realm.write({
            realm.add(realmObject)
        })
    }
    
    func fetchSavedData<T: RealmSwiftObject>(type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    
}
