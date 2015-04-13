//
//  SoundController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 10/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit
import AVFoundation

class SoundController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var soundRecorder: AVAudioRecorder!
    var soundPlayer:AVAudioPlayer!
    
    let fileName = "demo.caf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
    }
    
    @IBAction func recordSound(sender: UIButton) {
        if (sender.titleLabel?.text == "Record"){
            soundRecorder.record()
            sender.setTitle("Stop", forState: .Normal)
            playButton.enabled = false
        } else {
            soundRecorder.stop()
            sender.setTitle("Record", forState: .Normal)
        }
    }
    
    @IBAction func playSound(sender: UIButton) {
        if (sender.titleLabel?.text == "Play"){
            recordButton.enabled = false
            sender.setTitle("Stop", forState: .Normal)
            preparePlayer()
            soundPlayer.play()
        } else {
            soundPlayer.stop()
            sender.setTitle("Play", forState: .Normal)
        }
    }
    
    // MARK:- AVRecorder Setup
    
    func setupRecorder() {
        
        //set the settings for recorder
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        var error: NSError?
        
        soundRecorder = AVAudioRecorder(URL: getFileURL(), settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        if let err = error {
            println("AVAudioRecorder error: \(err.localizedDescription)")
        } else {
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }
    }
    
    // MARK:- Prepare AVPlayer
    
    func preparePlayer() {
        var error: NSError?
        
        soundPlayer = AVAudioPlayer(contentsOfURL: getFileURL(), error: &error)
        
        if let err = error {
            println("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        }
    }
    
    // MARK:- File URL
    
    func getCacheDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory,.UserDomainMask, true) as! [String]
        
        return paths[0]
    }
    
    func getFileURL() -> NSURL {
        
        let path =  getCacheDirectory().stringByAppendingPathComponent(fileName)
        let filePath = NSURL(fileURLWithPath: path)
        
        return filePath!
    }
    
    // MARK:- AVAudioPlayer delegate methods
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        playButton.setTitle("Play", forState: .Normal)
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Error while playing audio \(error.localizedDescription)")
    }
    
    // MARK:- AVAudioRecorder delegate methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        playButton.enabled = true
        recordButton.setTitle("Record", forState: .Normal)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Error while recording audio \(error.localizedDescription)")
    }
    
    // MARK:- didReceiveMemoryWarning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
