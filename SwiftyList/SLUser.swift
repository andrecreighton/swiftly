//
//  SLUser.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/15/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit

class SLUser: NSObject {
    
    var id     : Int!
    var gender : Character!
    var name   : String!
    var age    : Int!
    
    init(gender: Character, name: String, age: Int, id: Int) {
        super.init()
        
        self.gender = gender
        self.name   = name
        self.age    = age
        self.id     = id
        
        
    }
    
    
    

}
