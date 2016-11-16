//
//  SLTableViewController.swift
//  SwiftyList
//
//  Created by Andre Creighton on 11/15/16.
//  Copyright © 2016 Andre Creighton. All rights reserved.
//

import UIKit

class SLTableViewController: UITableViewController {

    var newView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height/2))
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.title = "Profiles"
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("SLProfileTableViewCell", owner: self, options: nil)?.first as! SLProfileTableViewCell
        
     cell.profileImageView.image = UIImage(named: "lalala")?.circleMask
        
        
        let uuid = UUID().uuidString
        print(uuid)
        
        
        return cell
    }
 
    func addTapped(){
        
        print(newView)
        
//        self.navigationController?.view.window?.addSubview(newView)
        navigationController?.view.window?.addSubview(newView)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return 120
    }
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
