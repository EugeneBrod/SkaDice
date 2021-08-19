//
//  ViewController.swift
//  SkateDie
//
//  Created by Eugene Brodsky on 8/17/21.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    var tasteful = true
    var repeats = false
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let img = UIImage(named: "orange_wheel")
        wheelGraphic.image = img
        wheelGraphic.isUserInteractionEnabled = true
        
        let img2 = UIImage(named: "pink_wheel")
        wheelGraphic2.image = img2
        wheelGraphic2.isUserInteractionEnabled = true
        
        settingsLabel.text = "NO REPEATS AND TASTEFUL"
    }
    
    
    @IBOutlet weak var wheelGraphic: UIImageView!
    
    @IBOutlet weak var wheelGraphic2: UIImageView!
    
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
        if (angle >= -(Double.pi/2) && angle <= (Double.pi/2)) {
            repeats = false
            if (tasteful) {
                settingsLabel.text = "NO REPEATS AND TASTEFUL"
            }
            else {
                settingsLabel.text = "NO REPEATS AND TASTELESS"
            }
        }
        else {
            repeats = true
            if (tasteful) {
                settingsLabel.text = "REPEATS AND TASTEFUL"
            }
            else {
                settingsLabel.text = "REPEATS AND TASTELESS"
            }
        }
     
    }
    
    func upDateTastefulSetting(angle: Double ) {
        if (angle >= -(Double.pi/2) && angle <= (Double.pi/2)) {
            tasteful = true
            if (repeats) {
                settingsLabel.text = "REPEATS AND TASTEFUL"
            }
            else {
                settingsLabel.text = "NO REPEATS AND TASTEFUL"
            }
        }
        else {
            tasteful = false
            if (repeats) {
                settingsLabel.text = "REPEATS AND TASTELESS"
            }
            else {
                settingsLabel.text = "NO REPEATS AND TASTELESS"
            }
        }
     
    }

        

    @IBAction func startGame(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        vc.repeats = self.repeats
        vc.tasteful = self.tasteful
        show(vc, sender:self)    }
}

