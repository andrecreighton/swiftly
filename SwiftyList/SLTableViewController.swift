//
//  SLTableViewController.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/15/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase


class SLTableViewController: UITableViewController, UITextFieldDelegate , UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var blurEffectView : UIVisualEffectView!
    var thisRef        : FIRDatabaseReference!
    var newView        = SLAddProfileOverlay()
    let imagePicker    = UIImagePickerController()
    
    
    func notifyCancelTapped(){
        
        newView.firstnameTextField.endEditing(true)
        newView.lastnameTextField.endEditing(true)
        newView.hobbyTextField.endEditing(true)
        newView.ageTextField.endEditing(true)
        
        
        newView.firstnameTextField.text = ""
        newView.lastnameTextField.text = ""
        newView.hobbyTextField.text = ""
        newView.ageTextField.text = ""
        
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.blurEffectView.removeFromSuperview()

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.70, initialSpringVelocity: 0, options: [], animations: {
            
            self.newView.alpha = 0
            self.newView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            self.newView.layoutSubviews()
            
        }, completion: nil)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newView.firstnameTextField {
            newView.lastnameTextField.becomeFirstResponder()
        }
        else if textField == newView.firstnameTextField {
            newView.lastnameTextField.becomeFirstResponder()
        }
        else if textField == newView.ageTextField {
            newView.hobbyTextField.becomeFirstResponder()
        }

        
        return true
    }
    
    
    
    
 
    func constraints(){
        
        newView.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo((self.navigationController?.view.window)!)
            make.centerY.equalTo((self.navigationController?.view.window)!).offset(-70)
            make.height.equalTo((self.navigationController?.view.window)!).multipliedBy(0.5)
            make.width.equalTo((self.navigationController?.view.window)!).multipliedBy(0.9)
        }
        
        navigationController?.view.window?.layoutSubviews()
        
        
    }
    

    func filterTapped(){
        
        
        print("lala")
        
    }
    
    
    func notifyPhotoTapped(){
        
        
        
        print("photo button responds")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
 
    
    func addTapped(){
        
      
        
        
        let randomnumber = Int(arc4random_uniform(100)) + 1000
        print(randomnumber)
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
  
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        self.view.addSubview(self.blurEffectView)
        self.view.bringSubview(toFront: self.blurEffectView)
        self.tableView.isUserInteractionEnabled = false
 
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.60, initialSpringVelocity: 0, options: [], animations: {
            
            self.newView.firstnameTextField.becomeFirstResponder()
            self.newView.alpha = 1
            self.newView.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1.0)
          
            
            self.newView.layoutSubviews()
            
        }, completion: nil)
        
        
        

    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("SLProfileTableViewCell", owner: self, options: nil)?.first as! SLProfileTableViewCell
        
        cell.profileImageView.image = UIImage(named: "lalala")?.circleMask
        
        
        if((indexPath.row + 1) % 2 == 0){
            
            cell.contentView.backgroundColor = UIColor.green
        }
        
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thisRef = FIRDatabase.database().reference().child("users")
        
        imagePicker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCancelTapped), name: NSNotification.Name(rawValue: "cancel tapped"), object: nil)
       
        NotificationCenter.default.addObserver(self, selector: #selector(notifyPhotoTapped), name: NSNotification.Name(rawValue: "add photo"), object: nil)
        
        
        newView = SLAddProfileOverlay()
        newView.firstnameTextField.delegate = self
        newView.lastnameTextField.delegate = self
        
        
        
        newView.alpha = 0
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.title = "Profiles"
        navigationController?.view.window?.addSubview(newView)
        
        
        
        self.constraints()
        
        
    }
    
    
}
