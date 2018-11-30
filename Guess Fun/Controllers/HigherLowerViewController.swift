//
//  HigherLowerViewController.swift
//  Guess Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import UIKit
import StoreKit

class HigherLowerViewController: UIViewController {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var trophyLabel: UILabel!
    
    
    // MARK: Properties
    
    var high = 1001
    var low = 0
    var guess = 0
    var diff = 0
    var half_diff = 0
    var tries = 0
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor : view.tintColor,
                ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor : view.tintColor,
                ], for: .highlighted)
                
        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        trophyLabel.isHidden = true
        
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(showNextGuess))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    // MARK: Helpers
    
    @objc func showNextGuess() {

        tries += 1
        
        diff = high - low
        
        if diff == 3 {
            half_diff = 2
        } else {
            half_diff = diff / 2
        }
        
        guess = low + half_diff
        
        guessLabel.isHidden = false
        guessLabel.text = "Is it \(guess)?"
        
        let lowerButton = UIBarButtonItem(title: "👇", style: .plain, target: self, action: #selector(lower))
        let higherButton = UIBarButtonItem(title: "👆", style: .plain, target: self, action: #selector(higher))
        let yesButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(correct))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if half_diff == 1 {
            guessLabel.text = "You thought: \(guess)"
            myToolbar.setItems([space, yesButton, space], animated: true)
        } else {
            myToolbar.setItems([lowerButton, space, yesButton, space, higherButton], animated: true)
        }
        
    }
    
    
    @objc func lower() {

        high = guess
        showNextGuess()
    }
    
    
    @objc func higher() {
        low = guess
        showNextGuess()
    }
    
    
    @objc func correct() {
        
        let trophies = ["⭐️", "⭐️⭐️", "⭐️⭐️⭐️", "🎖", "🎖🎖", "🎖🎖🎖", "🥉", "🥈", "🥇"]
        trophyLabel.text = ""
        trophyLabel.isHidden = false
        
        switch tries {
        case 1:
            guessLabel.text = "You thought: \(guess)\nThat took me 1 try."
            trophyLabel.text = "🏅"
        case 2, 3, 4, 5, 6, 7, 8, 9:
            guessLabel.text = "You thought: \(guess)\nThat took me \(tries) tries!"
            trophyLabel.text = trophies[tries - 2]
        case 10:
            guessLabel.text = "You thought: \(guess)\nThat took me 10 tries!"
            trophyLabel.text = "🥇"
        default:
            guessLabel.text = "Oops! It took me more than 10 tries. Please let the developer know this happened."
            trophyLabel.text = "🏆"
        }
        
        let doneButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton, space], animated: true)
    }
    
    
    // MARK: Action
    
    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
        SKStoreReviewController.requestReview()
    }
    
}





