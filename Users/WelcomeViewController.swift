//
//  ViewController.swift
//  MediaPlayer
//
//  Created by BenLai on 22/8/2015.
//  Copyright (c) 2015年 BenLai. All rights reserved.
//
//
//  WelcomeViewController.swift
//  Users
//
//  Created by harrison on 28/8/15.
//  Copyright (c) 2015 harrison. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class WelcomeViewController: PFQueryTableViewController {
    var currentUser = PFUser.currentUser()
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue){
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
        currentUser = PFUser.currentUser() // this will now be nil
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Song"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Song")
        query.orderByAscending("name")
        query.whereKey("owner", equalTo: (currentUser)!)
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["name"] as? String {
            cell?.textLabel?.text = name
        }
        if let artist = object?["artist"] as? String {
            cell?.detailTextLabel?.text = artist
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender is PFTableViewCell{
            // Get the new view controller using [segue destinationViewController].
            var detailScene = segue.destinationViewController as! DetailViewController
        
            // Pass the selected object to the destination view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let row = Int(indexPath.row)
                detailScene.currentObject = (objects?[row] as! PFObject)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentUser != nil {
//            let instrument = AKInstrument()
//            instrument.setAudioOutput(AKOscillator())
//            AKOrchestra.addInstrument(instrument)
//            instrument.play()
            // Import some sample songs
//            var song = PFObject(className:"Song")
//            song["name"] = "Light theme"
//            song["artist"] = "Death Note"
//            song["album"] = "Death Note"
//            song["link"] = "http://localhost:8000/light.mp3"
//            song["mood"] = "Evil"
//            song["owner"] = currentUser
//            song.saveInBackgroundWithBlock {
//                (success: Bool, error: NSError?) -> Void in
//                if (success) {
//                    // The object has been saved.
//                } else {
//                    // There was a problem, check error.description
//                }
//            }
            
        } else {
            // Show the signup or login screen
            
        }
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
