//
//  SLLaunchViewController.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/18/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase

class SLLaunchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet var profileTableView: UITableView!
    var blurEffectView : UIVisualEffectView!
    var newView        = SLAddProfileOverlay()
    let imagePicker    = UIImagePickerController()
    var thisRef        : FIRDatabaseReference!
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == newView.firstnameTextField) {
            newView.lastnameTextField.becomeFirstResponder()
        }
        if (textField == newView.lastnameTextField) {
            newView.hobbyTextField.becomeFirstResponder()
        }
        if (textField == newView.hobbyTextField) {
            newView.ageTextField.becomeFirstResponder()
        }
        
        
        return true
    }
    
    
    func filterTapped(){
        
        
        print("lala")
        
    }
    

    // MARK: - Functionaity for the overlay view
    
    func addTapped(){
    
        let randomnumber = Int(arc4random_uniform(100)) + 1000
        print(randomnumber)
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        self.view.addSubview(self.blurEffectView)
        self.profileTableView.isUserInteractionEnabled = false
        self.view.bringSubview(toFront: newView)
        
        
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.60, initialSpringVelocity: 0, options: [], animations: {
            
            self.newView.firstnameTextField.becomeFirstResponder()
            self.newView.alpha = 1
            self.newView.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1.0)
            
            
            self.newView.layoutSubviews()
            
        }, completion: nil)
        
        
        
        
    }
    
    func notifyCancelTapped(){
        
        newView.firstnameTextField.endEditing(true)
        newView.lastnameTextField.endEditing(true)
        newView.hobbyTextField.endEditing(true)
        newView.ageTextField.endEditing(true)
        
        
        newView.firstnameTextField.text = ""
        newView.lastnameTextField.text = ""
        newView.hobbyTextField.text = ""
        newView.ageTextField.text = ""
        newView.addPhotoImageView.image = UIImage(named: "")
        
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.blurEffectView.removeFromSuperview()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.70, initialSpringVelocity: 0, options: [], animations: {
            
            self.newView.alpha = 0
            self.newView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            self.newView.layoutSubviews()
            
        }, completion: nil)
        
    }
    
    
// MARK: -
    
    
    func constraints(){
        
        newView.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.6)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.view.snp.topMargin).offset(10)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = Bundle.main.loadNibNamed("SLProfileTableViewCell", owner: self, options: nil)?.first as! SLProfileTableViewCell
        
        cell.profileImageView.image = UIImage(named: "lalala")?.circleMask
        
        
        
        return cell;
        
    }
    
    @IBAction func whenFilterButtonTapped(_ sender: Any) {
        
        
        
        

    }

    @IBAction func whenAddPhotoButtonTapped(_ sender: Any) {
        
        
        
        
        
    }
    
    func notifyAddProfileTapped(){
        
        
        
        
        
        
        
        
    }
    
    func notifyPhotoTapped(){
        
        
        
        print("photo button responds")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    
    // MARK: - UIImagePickerController Delegate Methods
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("did cancel")
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newView.addPhotoImageView.contentMode = .scaleAspectFill
            newView.addPhotoImageView.image = pickedImage
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
   // MARK: - viedDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         thisRef = FIRDatabase.database().reference().child("users")
        
        
        
        newView = SLAddProfileOverlay()
        newView.alpha = 0
        self.view.addSubview(newView)
        self.constraints()
        
        contentView.frame = self.view.bounds
        profileTableView.delegate = self
        profileTableView.dataSource = self
        newView.firstnameTextField.delegate = self
        newView.lastnameTextField.delegate = self
        newView.hobbyTextField.delegate = self
        newView.ageTextField.delegate = self
        imagePicker.delegate = self
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifyPhotoTapped), name: NSNotification.Name(rawValue: "add photo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCancelTapped), name: NSNotification.Name(rawValue: "cancel tapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifyAddProfileTapped), name: NSNotification.Name(rawValue: "add profile"), object: nil)
        
        
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.title = "Profiles"
        
        
        
        
        // Do any additional setup after loading the view.
        
        
    }

    

}
    
