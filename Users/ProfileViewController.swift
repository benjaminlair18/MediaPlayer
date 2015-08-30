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
    @IBOutlet weak var imageView: UIImageView!
    var gravatarHashLink: String = ""
    
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
        gravatarHashLink = "http://www.gravatar.com/avatar/" + emailField.text.md5() + "?s=128"
        let checkedUrl = NSURL(string: gravatarHashLink)!
        var asyncgetter = AsyncImageGetter()
        asyncgetter.downloadImage(checkedUrl, callback: { data in
            self.imageView.image = UIImage(data: data!)
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
            self.imageView.clipsToBounds = true
        })
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
