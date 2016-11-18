//
//  SLUserObject.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/18/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import Foundation

struct User {
    
    let name     : String
    let age      : String
    let gender   : String
    let uniqueID : String
    let photoUrl : String
    
    
    init (name: String, age: String, gender:String, uniqueID: String, photoUrl: String){
        
        self.name       = name
        self.age        = age
        self.gender     = gender
        self.uniqueID   = uniqueID
        self.photoUrl   = photoUrl
        
        
    }
    
    
    
    
    
    
}
