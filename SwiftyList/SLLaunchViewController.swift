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
    var userArray      = [SLUser]()
    
    
    func observeDatabase(){
        
        
        thisRef.observe(.childAdded, with: {(snapshot:FIRDataSnapshot) -> Void in
            
            
            let userDicitonary = snapshot.value as? NSDictionary
            
            
            let name = userDicitonary?["Name"] as! String
            let age  = userDicitonary?["Age"] as! String
            let gender = userDicitonary?["Gender"] as! String
            let hobbies = userDicitonary?["Hobbies"] as! String
            let uniqueID = userDicitonary?["UniqueID"] as! String
            

            self.userArray.append((SLUser(name: name, age: age, gender: gender, hobbies: hobbies, uniqueID: uniqueID)))
            self.profileTableView.reloadData()
            
        })
        
        
        
        
    }
    

    
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
        if (textField == newView.ageTextField) {
            newView.ageTextField.endEditing(true)
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
    
    func removeOverlay(){
        
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
        
        
           self.profileTableView.isUserInteractionEnabled = true
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

    
    func notifyAddProfileTapped(){
  
        
        let randomnumber = Int(arc4random_uniform(100)) + 1000
       
        let uniqueID = String(format: "%d", randomnumber)
        
        let name = newView.firstnameTextField.text! + " " + newView.lastnameTextField.text!
        let age = newView.ageTextField.text!
        let hobbies = newView.hobbyTextField.text!
        let gender = newView.genderSegmentControl.titleForSegment(at: newView.genderSegmentControl.selectedSegmentIndex)!
        
        
        let user = SLUser(name: name, age: age, gender: gender, hobbies: hobbies, uniqueID: uniqueID)
        
        thisRef.childByAutoId().setValue(user.userDicitonary)
        removeOverlay()

    }

   // MARK: - UIImagePickerController Delegate Methods
    
    
    func notifyPhotoTapped(){
        

        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    
 
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
 
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newView.addPhotoImageView.contentMode = .scaleAspectFill
            newView.addPhotoImageView.image = pickedImage
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
       // MARK: - TableView Methods
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return userArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = Bundle.main.loadNibNamed("SLProfileTableViewCell", owner: self, options: nil)?.first as! SLProfileTableViewCell
        
        cell.profileImageView.backgroundColor = UIColor.lightGray
        cell.nameLabel.text! = userArray[indexPath.row].name
        let age = userArray[indexPath.row].age
        let ageString = String(format: "%@ years old", age)
        cell.ageLabel.text!  = ageString
        
        cell.genderLabel.text! = userArray[indexPath.row].gender
        if(cell.genderLabel.text == "Female"){
            
            cell.contentView.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 176/255, blue: 25/255, alpha: 0.75)
        }
        
        cell.hobbiesDescriptionLabel.text! = userArray[indexPath.row].hobbies
        
        
        // 14 176 25 .75
        
        return cell;
        
    }
    
    
   // MARK: - viedDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thisRef = FIRDatabase.database().reference().child("users")
        observeDatabase()
        
        
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeOverlay), name: NSNotification.Name(rawValue: "cancel tapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifyAddProfileTapped), name: NSNotification.Name(rawValue: "add profile"), object: nil)
        
        
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.title = "Profiles"
        
        
        
        // Do any additional setup after loading the view.
        
        
    }

    

}
    
