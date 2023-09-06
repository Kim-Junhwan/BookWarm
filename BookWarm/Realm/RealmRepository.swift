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
    func checkDataIsContain<T: RealmSwiftObject>(type: T.Type, key: Any) -> Bool
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
    
    func checkDataIsContain<T: RealmSwiftObject, Key>(type: T.Type, key: Key) -> Bool  {
        if realm.object(ofType: type, forPrimaryKey: key) == nil {
            return false
        }
        return true
    }
    
}
