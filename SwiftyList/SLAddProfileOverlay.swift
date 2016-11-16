//
//  SLAddProfileOverlay.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/16/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit

class SLAddProfileOverlay: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var addProfileButton: UIButton!
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        setUpView()
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
         super.init(coder: aDecoder)
        setUpView()
        
    }


    
    func setUpView() {
        
        UINib(nibName: "SLAddProfileOverlay", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView!)
        contentView.frame = bounds
        
        
        
        
    }
    
    
}
