//
//  SLFilterView.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/21/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit

class SLFilterView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var genderFilterControl: UISegmentedControl!
    @IBOutlet var ageSorterLabel: UILabel!
    @IBOutlet var ageSorterControl: UISegmentedControl!
    @IBOutlet var nameSortLabel: UILabel!
    @IBOutlet var nameSorterControl: UISegmentedControl!
    
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        setUpView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setUpView()
        
    }

    
    
    func setUpView() {
        
        UINib(nibName: "SLFilterView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView!)
        contentView.frame = bounds
        
        
    }
    
    
    @IBAction func cancelFromFilterTapped(_ sender: Any) {
        
        
        let notification = Notification.Name("filterCancel")
        NotificationCenter.default.post(name: notification, object: nil)
        
        
    }
    
    
}
