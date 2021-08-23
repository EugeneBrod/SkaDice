//
//  Game.swift
//  SkateDie
//
//  Created by Eugene Brodsky on 8/17/21.
//

import UIKit

class GameViewController: UIViewController {
    
    var repeats = false
    var tasteful = false
    var tricks = [String]()
    
    @IBOutlet weak var trickLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readInTricks()
        if (tricks[tricks.count-1] == "") {
            tricks.remove(at: tricks.count - 1)
        }
    }
    
    @IBAction func roll(_ sender: Any) {
        if (tricks.count == 0) {
            trickLabel.text = "Out of Tricks!"
            return
        }
        let randomidx = Int.random(in: 0..<tricks.count)
        UILabel.transition(with: trickLabel,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: {
                        self.trickLabel.text = self.tricks[randomidx]
                 }, completion: nil)
        if (!self.repeats) {
            tricks.remove(at: randomidx)
        }
    }
    

    @IBAction func goBack(_ sender: Any) {
    
        self.dismiss(animated:true, completion:nil)
    }
    
    
    func readInTricks() {
        if let path = Bundle.main.path(forResource: "tricks", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                if (!self.tasteful) {
                    for (idx, trick) in myStrings.enumerated() {
                        if (idx == myStrings.count-1) {
                            continue
                        }
                        if (idx%2==0 && myStrings[idx+1] == "0") {
                            self.tricks.append(trick)
                        }
                    }
                }
                else {
                    for index in 0...myStrings.count-2 {
                        if (index%2 == 1) {
                            continue
                        }
                        else {
                            if (myStrings[index + 1] == "0") {
                                continue
                            }
                            else {
                                self.tricks.append(myStrings[index])
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    

    
    

}
