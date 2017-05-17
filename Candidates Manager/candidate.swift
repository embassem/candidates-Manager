//
//	candidate.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift
import Realm
class Candidate: Object {

	dynamic var locationLat: Double = 0.0
	dynamic var locationLong: Double = 0.0
	dynamic var position: String!
	dynamic var mobile: String!
	dynamic var name: String!

    dynamic var createdAt = Date()
    dynamic var photo:Data? = nil;
    dynamic var others:Data? = nil;
    
    


    
    public init(position: String, mobile: String, name: String) {
        super.init()
        self.position = position
        self.mobile = mobile
        self.name = name
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema);
//        fatalError("init(realm:schema:) has not been implemented")
    }
    
       
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema);
//        fatalError("init(value:schema:) has not been implemented")
    }
    

}
