//
//  SLUser.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/19/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct SLUser {
    
    
    let name     : String
    let age      : String
    let gender   : String
    let hobbies  : String
    let uniqueID : String
    let userDicitonary : Dictionary<String, String>
    
    
    
    init (name: String, age: String, gender:String, hobbies: String,  uniqueID: String){
        
        self.name        = name
        self.age         = age
        self.gender      = gender
        self.uniqueID    = uniqueID
        self.hobbies     = hobbies
        
        
        
        self.userDicitonary = ["Name"       : self.name,
                               "Age"        : self.age,
                               "Gender"     : self.gender,
                               "UniqueID"   : self.uniqueID,
                               "Hobbies"    : self.hobbies]
        
        
    }
    

    
    

}
