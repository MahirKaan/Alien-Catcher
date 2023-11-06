//
//  ViewController.swift
//  Alien Catcher
//
//  Created by Mahir Kaan Küçükgençay on 28.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var alienAray = [UIImageView] ()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var firstAlien: UIImageView!
    @IBOutlet weak var secondAlien: UIImageView!
    @IBOutlet weak var thirdAlien: UIImageView!
    @IBOutlet weak var fourthAlien: UIImageView!
    @IBOutlet weak var fifthAlien: UIImageView!
    @IBOutlet weak var sixthAlien: UIImageView!
    @IBOutlet weak var seventhAlien: UIImageView!
    @IBOutlet weak var eighthAlien: UIImageView!
    @IBOutlet weak var ninthAlien: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Number of aliens killed \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil{
            highScore = 0
            highscoreLabel.text = "Highscore:\(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "Highsocre: \(highScore)"
        }
    
        firstAlien.isUserInteractionEnabled = true
        secondAlien.isUserInteractionEnabled = true
        thirdAlien.isUserInteractionEnabled = true
        fourthAlien.isUserInteractionEnabled = true
        fifthAlien.isUserInteractionEnabled = true
        sixthAlien.isUserInteractionEnabled = true
        seventhAlien.isUserInteractionEnabled = true
        eighthAlien.isUserInteractionEnabled = true
        ninthAlien.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        firstAlien.addGestureRecognizer(recognizer1)
        secondAlien.addGestureRecognizer(recognizer2)
        thirdAlien.addGestureRecognizer(recognizer3)
        fourthAlien.addGestureRecognizer(recognizer4)
        fifthAlien.addGestureRecognizer(recognizer5)
        sixthAlien.addGestureRecognizer(recognizer6)
        seventhAlien.addGestureRecognizer(recognizer7)
        eighthAlien.addGestureRecognizer(recognizer8)
        ninthAlien.addGestureRecognizer(recognizer9)
        
        alienAray = [firstAlien,secondAlien,thirdAlien,fourthAlien,fifthAlien,sixthAlien,seventhAlien,eighthAlien,ninthAlien]
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAlien), userInfo: nil, repeats: true)
        
        hideAlien()
        
    }
    
    @objc func hideAlien() {
        for alien in alienAray {
            alien.isHidden = true
        }
        let random =  Int(arc4random_uniform(UInt32(alienAray.count - 1)))
        alienAray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Number of aliens killed \(score)"
        
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for alien in alienAray {
                alien.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Number of aliens killed \(score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAlien), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
            
    }
    
    
    
    
}
