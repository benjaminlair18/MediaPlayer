//
//  ProfileViewController.swift
//  Users
//
//  Created by harrison on 28/8/15.
//  Copyright (c) 2015 harrison. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBAction func saveAction(sender: AnyObject) {
        PFUser.currentUser()?.username = nameField.text
        PFUser.currentUser()?.email = emailField.text
        PFUser.currentUser()?.password = passField.text
        PFUser.currentUser()?.saveInBackground()
//        self.performSegueWithIdentifier("unwindToWelcome", sender: self)
        self.navigationController?.popViewControllerAnimated(true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = PFUser.currentUser()?.username
        emailField.text = PFUser.currentUser()?.email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
