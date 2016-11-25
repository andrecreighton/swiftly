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
import FirebaseStorage


class SLLaunchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate, FilterViewDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet var profileTableView: UITableView!
    var blurEffectView : UIVisualEffectView!
    var newView        = SLAddProfileOverlay()
    var filterView     = SLFilterView()
    let profileView    = SLProfileViewController()
    let imagePicker    = UIImagePickerController()
    var thisRef        : FIRDatabaseReference!
    var storage        : FIRStorage!
    var storageRef     : FIRStorageReference!
    var downloadURL    : URL!
   // var userArray      = [SLUser]()
    var userArray      = [Dictionary<String,Any>]()
    var sortedArray    = [Dictionary<String,Any>]()
    var segueIdentifier : String!
    
    func observeDatabase(){
        
        
        thisRef.observe(.childAdded, with: {(snapshot:FIRDataSnapshot) -> Void in
        
            let userDictionary = snapshot.value as? NSDictionary
            
        
            
//            let name = userDictionary?["Name"] as! String
//            let age  = userDictionary?["Age"] as! String
//            let gender = userDictionary?["Gender"] as! String
//            let hobbies = userDictionary?["Hobbies"] as! String
//            let uniqueID = userDictionary?["UniqueID"] as! NSNumber
//            let photoUrl = userDictionary?["Download URL"] as! String
            // self.userArray.append((SLUser(name: name, age: age, gender: gender, hobbies: hobbies, uniqueID: uniqueID, photoUrl: photoUrl)))
            
            
            
            
            self.userArray.append(userDictionary as! [String : Any])
            
            
            
         //   self.userArray.insert((SLUser(name: name, age: age, gender: gender, hobbies: hobbies, uniqueID: uniqueID, photoUrl: photoUrl)), at: 0)
            
            
            
    //Default order of array by uniqueID
            
            
            self.sortedArray = (self.userArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "UniqueID", ascending: true)]) as! [[String:Any]]
            
            
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                DispatchQueue.main.async(execute: {
                        self.profileTableView.reloadData()
                })
                
            }
      
            
            
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


    // MARK: - Functionaity for the overlay and filter views
    
    func addTapped(){
        
        self.blurEffectView.alpha = 1
    
        let randomnumber = Int(arc4random_uniform(100)) + 1000
        print(randomnumber)
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
   
        self.profileTableView.isUserInteractionEnabled = false
        self.view.bringSubview(toFront: newView)
        
        self.newView.firstnameTextField.becomeFirstResponder()
        
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.60, initialSpringVelocity: 0, options: [], animations: {
        
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
        self.blurEffectView.alpha = 0
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.blurEffectView.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.70, initialSpringVelocity: 0, options: [], animations: {
            
            self.newView.alpha = 0
            self.newView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            self.newView.layoutSubviews()
            
        }, completion: nil)
        
        
           self.profileTableView.isUserInteractionEnabled = true
        
        self.filterView.alpha = 0
    }
    
    
    
    func filterViewShow(){
        
        
        print("Show yourself")
        self.blurEffectView.alpha = 1
        
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        self.view.bringSubview(toFront: filterView)
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.60, initialSpringVelocity: 0, options: [], animations: {
            
            self.filterView.alpha = 1
            self.filterView.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1.0)
            
            
            self.filterView.layoutSubviews()
            
        }, completion: nil)
        
        
        
        
        
    }
    func filterViewHide(){
        
        self.blurEffectView.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.70, initialSpringVelocity: 0, options: [], animations: {
            
            self.filterView.alpha = 0
            self.filterView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            self.filterView.layoutSubviews()
            
        }, completion: nil)
        
        
        self.profileTableView.isUserInteractionEnabled = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    func showResults(){
        
        self.userArray.removeAll()
        
        let genderName = filterView.genderSegmentedControl.titleForSegment(at: filterView.genderSegmentedControl.selectedSegmentIndex)!
        
        if(genderName == "Male" || genderName == "Female"){
        self.userArray.removeAll()
            
        let queryRef = thisRef.queryOrdered(byChild: "Gender").queryEqual(toValue: genderName)
        queryRef.observe(.childAdded, with: {(snapshot:FIRDataSnapshot) -> Void in
        
            
           let userDictionary = snapshot.value as? NSDictionary
            
            
            self.userArray.append(userDictionary as! [String : Any])
            self.sortedArray = (self.userArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "UniqueID", ascending: true)]) as! [[String:Any]]
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                DispatchQueue.main.async(execute: {
                    self.profileTableView.reloadData()
                })
                
            }

        })
        
    
        }
        
        self.filterViewHide()
        
    }
    
    func resetFilters(){
        print("reset filters")
        
        self.userArray.removeAll()
        
        self.observeDatabase()
        
        self.filterViewHide()
        
        filterView.genderSegmentedControl.selectedSegmentIndex = 1
      
    }
    
    
    
    func sendButtonTitle(title: String) {
        self.removeOverlay()
        
        if(title.contains("Name")){
            
            if(title.contains("Ascending")){
                
                self.sortedArray.removeAll()
                self.sortedArray = (self.userArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "Name", ascending: true)]) as! [[String:Any]]
                self.profileTableView.reloadData()
              
                
            }
            else{
                
                
                self.sortedArray.removeAll()
                self.sortedArray = (self.userArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "Name", ascending: false)]) as! [[String:Any]]
                self.profileTableView.reloadData()
                
                
            }
        }
        if(title.contains("Age")){
            
            if(title.contains("Ascending")){
                
                self.sortedArray.removeAll()
                self.sortedArray = (self.userArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "Age", ascending: true)]) as! [[String:Any]]
                self.profileTableView.reloadData()
                
                
            }
            else{
                
                
                self.sortedArray.removeAll()
                self.sortedArray = (self.userArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "Age", ascending: false)]) as! [[String:Any]]
                self.profileTableView.reloadData()
                
                
            }
        }
    
}
    
// MARK: - Constraints to overlay and filter views
    
    
    func constraintsForSubviews(){
        
        newView.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.6)
            make.width.equalTo(self.view).multipliedBy(0.95)
            make.top.equalTo(self.view.snp.topMargin).offset(10)
            
        }
        
        filterView.snp.makeConstraints { (make) in
            
            make.center.equalTo(self.view)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.7)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.85)
            
            
        }
        
        
    }

   // MARK: - Set user input in object to send to Firebase
    
    func notifyAddProfileTapped(){

        let data: Data = UIImagePNGRepresentation(newView.addPhotoImageView.image!)!
        
        
        let name = newView.firstnameTextField.text! + " " + newView.lastnameTextField.text!
        
        //Image
        let imageRef = storageRef.child(String(format :"%@.jpg", name))
        imageRef.put(data, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                self.addUserWithDownloadUrl(downloadUrl: downloadURL!)
            }
        }
        

    }

   
    func addUserWithDownloadUrl (downloadUrl : URL) {
        
        let randomnumber = Int(arc4random_uniform(100)) + 1000
        
        //let uniqueID = String(format: "%d", randomnumber)
        let uniqueID = NSNumber(integerLiteral: randomnumber)
        let name = newView.firstnameTextField.text! + " " + newView.lastnameTextField.text!
        let age = newView.ageTextField.text!
        let hobbies = newView.hobbyTextField.text!
        let gender = newView.genderSegmentControl.titleForSegment(at: newView.genderSegmentControl.selectedSegmentIndex)!

        let user = SLUser(name: name, age: age, gender: gender, hobbies: hobbies, uniqueID: uniqueID, photoUrl:downloadUrl.absoluteString)
        
        self.thisRef.childByAutoId().setValue(user.userDicitonary)

        
        self.removeOverlay()
                

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
    
// MARK: - UI stuff


func navigationBarSettings(){
    
    
    
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Create ", style: .plain, target: self, action: #selector(addTapped))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterViewShow))
    self.navigationItem.title = "Profiles"
    
    
    
    
}

// MARK: - Notification Central
    
    
func loadNotificationStack(){
    
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(notifyPhotoTapped), name: NSNotification.Name(rawValue: "add photo"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(removeOverlay), name: NSNotification.Name(rawValue: "cancel tapped"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(notifyAddProfileTapped), name: NSNotification.Name(rawValue: "add profile"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(filterViewHide), name:NSNotification.Name(rawValue:"filterCancel"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(resetFilters), name: NSNotification.Name(rawValue: "resetFilters"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(showResults), name:NSNotification.Name(rawValue:"showResults"), object: nil)
    
    
}

       // MARK: - TableView Methods




    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return sortedArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            
        let cell = Bundle.main.loadNibNamed("SLProfileTableViewCell", owner: self, options: nil)?.first as! SLProfileTableViewCell
        
        cell.selectionStyle = .none
        
    
//
//        cell.nameLabel.text! = self.userArray[indexPath.row].name
//        let age = self.userArray[indexPath.row].age
//        let ageString = String(format: "%@ years old", age)
//        cell.ageLabel.text!  = ageString
//        
//        cell.genderLabel.text! = self.userArray[indexPath.row].gender
//        if(cell.genderLabel.text == "Female"){
//
//            cell.contentView.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 176/255, blue: 25/255, alpha: 0.75)
//        }
//        cell.hobbiesDescriptionLabel.text! = self.userArray[indexPath.row].hobbies
//        cell.profileImageView.sd_setImage(with: URL(string: self.userArray[indexPath.row].photoUrl))
//
//        
    
        
                let nameString = self.sortedArray[indexPath.row]["Name"] as! String
                cell.nameLabel.text! = nameString
                let age = self.sortedArray[indexPath.row]["Age"] as! String
                let ageString = String(format: "%@ years old", age)
                cell.ageLabel.text!  = ageString
        
                cell.genderLabel.text! = self.sortedArray[indexPath.row]["Gender"] as! String
                if(cell.genderLabel.text == "Female"){
        
                    cell.contentView.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 176/255, blue: 25/255, alpha: 0.75)
                }
                cell.hobbiesDescriptionLabel.text! = self.sortedArray[indexPath.row]["Hobbies"] as! String
                cell.profileImageView.sd_setImage(with: URL(string: self.sortedArray[indexPath.row]["Download URL"] as! String))
        
        
                let numberString = String(describing: self.sortedArray[indexPath.row]["UniqueID"] as! NSNumber)
                cell.uniqueIDLabel.text! = numberString
    
       
        
            return cell;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let userDictionary = self.sortedArray[indexPath.row]
        print(userDictionary)
        
        
        
        let destination = SLProfileViewController(nibName: "SLProfileView", bundle: nil)
        
        navigationController?.pushViewController(destination, animated: true)
        
        

    }
   // MARK: - viedDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNotificationStack()
        self.navigationBarSettings()
        contentView.frame = self.view.bounds
        
        
        // Firebase Database Ref
        
        thisRef = FIRDatabase.database().reference().child("users")
   
        
        
        filterView.delegate = self
        filterView.alpha = 0
        newView.alpha = 0
        self.view.addSubview(filterView)
        self.view.addSubview(newView)
        self.constraintsForSubviews()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        self.view.addSubview(self.blurEffectView)
        self.blurEffectView.alpha = 0
   
        
        segueIdentifier = "segue"
        
        // DELEGATIONS
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        newView.firstnameTextField.delegate = self
        newView.lastnameTextField.delegate = self
        newView.hobbyTextField.delegate = self
        newView.ageTextField.delegate = self
        imagePicker.delegate = self
        
        
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            
            DispatchQueue.main.async(execute: {
                self.observeDatabase()
            })
            
        }
        
        
        
    }


}
