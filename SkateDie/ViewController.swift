//
//  ViewController.swift
//  SkateDie
//
//  Created by Eugene Brodsky on 8/17/21.
//

import UIKit


class ViewController: UIViewController {
    
    
    var tasteful = true
    var repeats = false
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func repeatsswitch(_ sender: UISwitch) {
        if (sender.isOn) {
            repeats = true
        }
        else {
            repeats = false
        }
    }
    
    @IBAction func tastefulswitch(_ sender: UISwitch) {
        if (sender.isOn) {
            tasteful = true
        }
        else {
            tasteful = false
        }
    }
    @IBAction func startGame(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        vc.repeats = self.repeats
        vc.tasteful = self.tasteful
        show(vc, sender:self)    }
}

