//
//  SLAddProfileOverlay.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/16/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit

class SLAddProfileOverlay: UIView {
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet var addProfileButton: UIButton!
    @IBOutlet var firstnameTextField: UITextField!
    @IBOutlet var lastnameTextField: UITextField!
    @IBOutlet var hobbyTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var addPhotoImageView: UIImageView!
    @IBOutlet var genderSegmentControl: UISegmentedControl!
    
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
    
    @IBAction func whenCancelButtonTapped(_ sender: Any) {
        
        let notification = Notification.Name("cancel tapped")
        NotificationCenter.default.post(name: notification, object: nil)
        
        
        
    }
    
    @IBAction func whenAddPhotoButtonTapped(_ sender: Any) {
        
        
        let notification = Notification.Name("add photo")
        NotificationCenter.default.post(name: notification, object: nil)
        
        
    }
    
    @IBAction func whenAddProfileButtonTapped(_ sender: Any) {
        
        
        let notfication = Notification.Name("add profile")
        NotificationCenter.default.post(name: notfication, object: nil)
        
    
        
        
    }
    
    
    
}


    
    

