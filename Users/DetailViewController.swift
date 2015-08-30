//
//  DetailViewController.swift
//  Users
//
//  Created by harrison on 28/8/15.
//  Copyright (c) 2015 harrison. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class DetailViewController: UIViewController {
    var currentObject : PFObject?
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var artistView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var albumView: UILabel!
    

    var link: String!
    var imgLink: String!
    var player: AVPlayer!
    var timer:NSTimer!

    
    @IBAction func playBtn(sender: AnyObject) {
        if (player.rate != 0 && player.error == nil){
            player.pause()
            playBtn.setImage(UIImage(named: "play"), forState: .Normal)
        }else{
            player.play()
            playBtn.setImage(UIImage(named: "pause"), forState: .Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Unwrap the current object object
        if let object = currentObject {
            nameView.text = object["name"] as? String
            artistView.text = object["artist"] as? String
            albumView.text = object["album"] as? String
            link = object["link"] as! String
            
            imgLink = ""
            if object["image"] != nil{
                imgLink = object["image"] as! String
                // Download image in an async method
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                if let checkedUrl = NSURL(string: imgLink) {
                    downloadImage(checkedUrl)
                }

            }
            
            player = AVPlayer(URL: NSURL(string: link))
            playBtn(self)
            
            

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url:NSURL){
        println("Started downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                println("Finished downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
                self.imageView.image = UIImage(data: data!)
                self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
                self.imageView.clipsToBounds = true
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {

//        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(link, ofType: "mp3")!)
//        var error: NSError? = nil
//        player = AVAudioPlayer(contentsOfURL: NSURL(string: link), error: &error)

        
//        slider2.value = 0
//        slider2.maximumValue = Float(player.duration)
////        timeView.text = String(format: "Song Length: %@",stringFromTimeInterval(player.duration))
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "ticker:", userInfo: nil, repeats: true)
        
    }
    
    func ticker(theTimer:NSTimer)
    {
//        self.slider2.value = Float(player.currentTime)
//        self.timeView.text = stringFromTimeInterval(player.currentTime)
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d",  minutes, seconds)
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
