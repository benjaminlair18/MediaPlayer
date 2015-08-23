//
//  ViewController.swift
//  MediaPlayer
//
//  Created by BenLai on 22/8/2015.
//  Copyright (c) 2015年 BenLai. All rights reserved.
//

import UIKit





class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var song = ["abc", "aof"]

    @IBOutlet var table: UITableView!
    
    let ins = AKInstrument()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ins.setAudioOutput(AKOscillator())
        AKOrchestra.addInstrument(ins)
        ins.play()
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidDisappear(animated: Bool) {
        ins.stop()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return song.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        cell.textLabel?.text = song[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toMediaPlayerViewController", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        
        if segue.identifier == "toMediaPlayerViewController"
        {
            
            
            let VC = segue.destinationViewController as! UIViewController
            
            let indexpath : NSIndexPath = table.indexPathForSelectedRow()!
            
            VC.title = song[indexpath.row]
           
        }
    }

}

