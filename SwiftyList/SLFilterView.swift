//
//  SLFilterView.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/21/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit



@objc protocol FilterViewDelegate{
    
    @objc func sendButtonTitle(title : String)
    
}



class SLFilterView: UIView {
    
    weak var delegate:FilterViewDelegate?

    @IBOutlet var contentView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var showResultsButton: UIButton!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var nameSegmentedControl: UISegmentedControl!
    @IBOutlet var ageSegmentedControl: UISegmentedControl!
    @IBOutlet var resetButton: UIButton!
    
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
        
        self.showResultsButton.layer.cornerRadius = self.showResultsButton.bounds.size.height/4
        
        
        
    }
    
    
    @IBAction func cancelFromFilterTapped(_ sender: Any) {
        
        
        let notification = Notification.Name("filterCancel")
        NotificationCenter.default.post(name: notification, object: nil)
        
        
        
    }
    
    @IBAction func whenResetTapped(_ sender: Any) {
        
        
        let notification = Notification.Name("resetFilters")
        NotificationCenter.default.post(name: notification, object: nil)
        
        
        
    }
    
    @IBAction func whenShowResultsTapped(_ sender: Any) {
        
        
        
        let notification = Notification.Name("showResults")
        NotificationCenter.default.post(name: notification, object: nil)
        
        
    }
    
    
    @IBAction func whenNameFilterTapped(_ sender: UIButton) {
        
        
        
        print(sender.titleLabel!.text!)
        
        if(sender.titleLabel?.text != nil){
            
            
            let string = sender.titleLabel!.text!
            
            self.delegate?.sendButtonTitle(title: string)
            
            
        
        }
        
        
        
        
    }
    
    
    
    
}
