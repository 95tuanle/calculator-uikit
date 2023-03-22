//
//  ViewController.swift
//  Calculator
//
//  Created by Nguyen Anh Tuan Le - N01414195 on 2022-09-23.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {
//    MARK: IBOutlet
    @IBOutlet var outputLbl: UILabel!
    
//    MARK: Variables
    var numberOnScreen: Double = 0.0
    
    var previousNumber: Double = 0.0
    
    var performingMath = false
    
    var operation = 0
    
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func playFartSound() {
            let url = Bundle.main.url(forResource: "dry-fart", withExtension: "mp3")
            btnSound = try! AVAudioPlayer(contentsOf: url!)
            btnSound.play()
    }
    
    func playQuackSound() {
            let url = Bundle.main.url(forResource: "quack_5", withExtension: "mp3")
            btnSound = try! AVAudioPlayer(contentsOf: url!)
            btnSound.play()
    }
    
    func messageBox(messageTitle: String, messageAlert: String, messageBoxStyle: UIAlertController.Style, alertActionStyle: UIAlertAction.Style) {
        let alert = UIAlertController(title: messageTitle, message: messageAlert, preferredStyle: messageBoxStyle)
        let okAction = UIAlertAction(title: "Ok", style: alertActionStyle) { _ in
            print("User click Ok button")
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
//    MARK: IBActions
    @IBAction func numberBtn(_ sender: UIButton) {
        playFartSound()
        if performingMath == true {
            outputLbl.text = ""
            outputLbl.text = String(sender.tag)
            numberOnScreen = Double(outputLbl.text!)!
            performingMath = false
        } else {
            outputLbl.text = outputLbl.text! + String(sender.tag)
            numberOnScreen = Double(outputLbl.text!)!
        }
    }
    
    @IBAction func operators(_ sender: UIButton) {
//        11 - equals
//        10 - clear
//        12 - add
//        13 - subtract
//        14 - div
//        15 - multiply
        
        if sender.tag == 16 {
            playQuackSound()
            messageBox(messageTitle: "Dear Mr. Mark,", messageAlert: "Thank you for teaching Swift.", messageBoxStyle: .alert, alertActionStyle: .default)
        } else {
            playFartSound()
            if (outputLbl.text != "" && sender.tag != 11 && sender.tag != 10) {
                previousNumber = Double(outputLbl.text!)!
                
                if sender.tag == 12 {
                    outputLbl.text = "+"
                } else if sender.tag == 13 {
                    outputLbl.text = "-"
                } else if sender.tag == 14 {
                    outputLbl.text = "/"
                } else if sender.tag == 15 {
                    outputLbl.text = "*"
                }
                
                operation = sender.tag
                
                performingMath = true
            } else if sender.tag == 11 {
                if operation == 12 {
                    outputLbl.text = String(previousNumber + numberOnScreen)
                } else if operation == 13 {
                    outputLbl.text = String(previousNumber - numberOnScreen)
                } else if operation == 14 {
                    outputLbl.text = String(previousNumber / numberOnScreen)
                } else if operation == 15 {
                    outputLbl.text = String(previousNumber * numberOnScreen)
                }
            } else if sender.tag == 10 {
                outputLbl.text = ""
                previousNumber = 0.0
                numberOnScreen = 0.0
                performingMath = false
            }
        }
    }
}

