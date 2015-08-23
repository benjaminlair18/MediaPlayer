//
//  MediaPlayerViewController.swift
//  MediaPlayer
//
//  Created by BenLai on 22/8/2015.
//  Copyright (c) 2015年 BenLai. All rights reserved.
//

import UIKit
import AVFoundation


class MediaPlayerViewController: UIViewController {

    
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    @IBOutlet var slider3: BWCircularSliderView!
    

    
    var timer:NSTimer!
    
    @IBOutlet var Image: UIImageView!
    
    @IBAction func pauseButton(sender: UIBarButtonItem)
    {
        player.pause()
        
    
        
    }
    
    @IBAction func plsyButton(sender: UIBarButtonItem)
    {
        player.play()
    }
    
    @IBAction func stopButton(sender: UIBarButtonItem)
    {
        
        
        player.stop()
        player.currentTime = 0
         slider2.value = Float(player.currentTime)
        
    }
    
    @IBOutlet var slider: UISlider!
    
    @IBAction func sliderController(sender: UISlider)
    {
       // player.volume = Float(Float(slider3.angles) / 100)
        
        
    }
    
    
    @IBOutlet var slider2: UISlider!
    
    
    
    @IBOutlet var Time: UILabel!

    @IBOutlet var Ctime: UILabel!
    
    
    @IBAction func slider2Controll(sender: UISlider, forEvent event: UIEvent) {
        
        
      player.currentTime = NSTimeInterval(slider2.value)
        
//       slider2.value = Float(player.currentTime)
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        self.Ctime.text = stringFromTimeInterval(NSTimeInterval (0))
        
        var image : UIImage = UIImage(named:self.navigationItem.title!)!
        
        
        Image.image = image

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d",  minutes, seconds)
    }
    
    
    func ticker(theTimer:NSTimer)
    {
    player.volume = Float(Float(slider3.angles) / 100)
    
        self.slider2.value = Float(player.currentTime)
        self.Ctime.text = stringFromTimeInterval(player.currentTime)
    
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        

        
        
        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(self.navigationItem.title, ofType: "mp3")!)
        
        var error: NSError? = nil
        
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation as String), error: &error)
        
        
        slider2.value = 0
        
        
        slider2.maximumValue = Float(player.duration)
        
        Time.text = String(format: "Song Length: %@",stringFromTimeInterval(player.duration))
        
        
        
        
        
        
        
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "ticker:", userInfo: nil, repeats: true)
        
        
          player.play()
        
 
        
       
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        
        if ((timer) != nil)
        {
            timer.invalidate()
            timer = nil
            
            
            
        }
        
        
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
