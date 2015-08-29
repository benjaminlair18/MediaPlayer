//
//  RegisterViewController.swift
//  Users
//
//  Created by harrison on 28/8/15.
//  Copyright (c) 2015 harrison. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var usertext: UITextField!
    @IBOutlet weak var passtext: UITextField!
    @IBOutlet weak var emailtext: UITextField!

    @IBAction func unwindToLogin(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func registerBtn(sender: AnyObject) {
        let user = PFUser()
        user.username = usertext.text
        user.password = passtext.text
        user.email = emailtext.text
        
        // other fields can be set if you want to save more information
//        user["phone"] = "650-555-0000"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? String
                // Show the errorString somewhere and let the user try again.
                var alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok, please forgive me", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // Hooray! Let them use the app now.
//                self.login(self.loginbtn)
                
                PFUser.logInWithUsernameInBackground(self.usertext.text, password: self.passtext.text) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // Do stuff after successful login.
                        self.performSegueWithIdentifier("loginAfterRegisterSegue", sender: self)
                        
                    } else {
                        // The login failed. Check error to see why.
                        var alert = UIAlertController(title: "Error", message: "Wrong username or password!", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok, please forgive me", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
                
                
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
