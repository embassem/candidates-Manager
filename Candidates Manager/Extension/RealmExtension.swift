
//
//  RealmExtension.swift
//  Candidates Manager
//
//  Created by Bassem Abbas on 5/17/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation
import RealmSwift


extension Results {
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    
    func toArray() -> [T] {
        return self.map{$0}
    }
}
