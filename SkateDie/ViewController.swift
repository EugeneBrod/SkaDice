//
//  ViewController.swift
//  SkateDie
//
//  Created by Eugene Brodsky on 8/17/21.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var videoLayer: UIView!
    
    @IBOutlet weak var tastefulLabel: UILabel!
    
    @IBOutlet weak var repeatsLabel: UILabel!
    
    @IBOutlet weak var wheelGraphic: UIImageView!
    
    @IBOutlet weak var wheelGraphic2: UIImageView!
    
    
    @IBOutlet weak var startGames: UIButton!
    
    @IBOutlet weak var diamond: UIImageView!
    
    
    var tasteful = true
    var repeats = false
    var player : AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let img = UIImage(named: "spitfire_wheel")
        wheelGraphic.image = img
        wheelGraphic.isUserInteractionEnabled = true
        
        let img2 = UIImage(named: "pink_wheel")
        wheelGraphic2.image = img2
        wheelGraphic2.isUserInteractionEnabled = true
        
        repeatsLabel.text = "NO REPEATS"
        tastefulLabel.text = "TASTEFUL"
        
        playVideo()
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "heaven", ofType: "mp4") else {
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player:player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        
        player?.play()
        videoLayer.bringSubviewToFront(wheelGraphic)
        videoLayer.bringSubviewToFront(wheelGraphic2)
        videoLayer.bringSubviewToFront(repeatsLabel)
        videoLayer.bringSubviewToFront(tastefulLabel)
        videoLayer.bringSubviewToFront(startGames)
        videoLayer.bringSubviewToFront(diamond)

        

    }
    
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch:UITouch = touches.first!

        if touch.view === wheelGraphic {


            let position = touch.location(in: self.view)
            let target = wheelGraphic.center
            let angle = atan2(target.y-position.y, target.x-position.x)
            wheelGraphic.transform = CGAffineTransform(rotationAngle: angle)
            upDateRepeatSetting(angle: Double(angle))


        }
        
        if touch.view === wheelGraphic2 {


            let position = touch.location(in: self.view)
            let target = wheelGraphic2.center
            let angle = atan2(target.y-position.y, target.x-position.x)
            wheelGraphic2.transform = CGAffineTransform(rotationAngle: angle)
            upDateTastefulSetting(angle: Double(angle))


        }
    }

    func upDateRepeatSetting(angle: Double ) {
        var string = ""
        if (angle >= -(Double.pi/2) && angle <= (Double.pi/2)) {
            repeats = false
            string = "NO REPEATS"
        }
        else {
            repeats = true
            string = "REPEATS"
        }
        if (repeatsLabel.text == string) {
            return
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UILabel.transition(with: repeatsLabel,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: {
                        self.repeatsLabel.text = string
                 }, completion: nil)
    }
    
    func upDateTastefulSetting(angle: Double ) {
        var string = ""
        if (angle >= -(Double.pi/2) && angle <= (Double.pi/2)) {
            tasteful = true
            string = "TASTEFUL"
        }
        else {
            tasteful = false
            string = "NOT TASTEFUL"
        }
        if (tastefulLabel.text == string) {
            return
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UILabel.transition(with: tastefulLabel,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: {
                        self.tastefulLabel.text = string
                 }, completion: nil)
     
    }
    

        

    @IBAction func startGame(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        vc.repeats = self.repeats
        vc.tasteful = self.tasteful
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender:self)
        
    }

}

