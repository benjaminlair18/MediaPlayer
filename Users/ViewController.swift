//
//  ViewController.swift
//  Users
//
//  Created by harrison on 28/8/15.
//  Copyright (c) 2015 harrison. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usertext: UITextField!
    @IBOutlet weak var passtext: UITextField!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBAction func login(sender: AnyObject) {
        loginToParse(usertext.text, pass: passtext.text)
    }
    
    func loginToParse(username: String?, pass: String?){
        PFUser.logInWithUsernameInBackground(username!, password: pass!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("loginViewSegue", sender: self)
                
            } else {
                // The login failed. Check error to see why.
                var alert = UIAlertController(title: "Error", message: "Wrong username or password!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok, please forgive me", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        self.performSegueWithIdentifier("registerSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passtext.secureTextEntry = true
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do stuff with the user
            self.performSegueWithIdentifier("loginViewSegue", sender: self)
        } else {
            // Show the signup or login screen
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

