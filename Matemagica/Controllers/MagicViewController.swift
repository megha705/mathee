//
//  MagicViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class MagicViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!


    // MARK: Properties

    var myTitle: String!
    var myThemeColor: UIColor!

    let progressFractions: Float = 10


    // MARK: Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matemagicaScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        leftButton.isHidden = true
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        headerLabel.text = """
        Think of a number (you might want pen and paper)

        Let us call your number: A
        """
        progressBar.setProgress(0, animated: false)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressBar.setProgress(progressBar.progress+(1/progressFractions), animated: true)
        middleButton.doGlowAnimation(withColor: myThemeColor)
    }


    // MARK: Helpers

    @objc func play() {
        headerLabel.text = """
        Now do: A + 10

        Let us call the result: B
        """

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(combineFirst), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)
        progressBar.setProgress(progressBar.progress+(1/progressFractions), animated: true)
    }


    @objc func combineFirst() {
        headerLabel.text = """
        Combine the digits of B

        For example, if B was 24, you would get 2 + 4 = 6

        Let us call the result of combining B's digits: C
        """

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(subtract), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)
        progressBar.setProgress(progressBar.progress+(1/progressFractions), animated: true)
    }


    @objc func subtract() {
        headerLabel.text = """
        Now do: B - C

        Let us call the result: D
        """

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(checkFirst), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)
        progressBar.setProgress(progressBar.progress+(1/progressFractions), animated: true)
    }


    @objc func checkFirst() {
        headerLabel.text = """
        Is D a single digit?
        """

        leftButton.isHidden = false
        leftButton.doGlowAnimation(withColor: myThemeColor)
        middleButton.isHidden = true
        rightButton.isHidden = false
        rightButton.doGlowAnimation(withColor: myThemeColor)

        leftButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(combineSecond), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(showResultFirst), for: .touchUpInside)
        rightButton.setTitleNew(Const.yesMessage)
        leftButton.setTitleNew(Const.noMessage)
        progressBar.setProgress(progressBar.progress+(1/progressFractions), animated: true)

    }


    @objc func combineSecond() {
        headerLabel.text =
            """
        Combine the digits of D

        For example, if D was 24, you would get 2 + 4 = 6
        """

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(checkForever), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)
        progressBar.setProgress(progressBar.progress+(1/progressFractions), animated: true)
    }


    @objc func checkForever() {
        headerLabel.text = "Is the new result a single digit?"

        leftButton.isHidden = false
        leftButton.doGlowAnimation(withColor: myThemeColor)
        middleButton.isHidden = true
        rightButton.isHidden = false
        rightButton.doGlowAnimation(withColor: myThemeColor)

        leftButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(combineForever), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(showResultFinally), for: .touchUpInside)
        rightButton.setTitleNew(Const.yesMessage)
        leftButton.setTitleNew(Const.noMessage)
        let remaining: Float = 1 - progressBar.progress
        let halfRemaining: Float = remaining / 2
        progressBar.setProgress(progressBar.progress+halfRemaining, animated: true)
    }


    @objc func combineForever() {
        headerLabel.text =
            """
        Combine the result's digits. For example, if your result is 24, do 2 + 4, and get 6
        """

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(checkForever), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)
        let remaining: Float = 1 - progressBar.progress
        let halfRemaining: Float = remaining / 2
        progressBar.setProgress(progressBar.progress+halfRemaining, animated: true)
    }


    @objc func showResultFirst() {
        headerLabel.attributedText = attrifyString(
            preString: "D is:\n\n", toAttrify: "9", postString: nil, color: myThemeColor)

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        middleButton.setTitleNew(Const.endMessage)
        progressBar.setProgress(1, animated: true)
    }


    @objc func showResultFinally() {
        headerLabel.attributedText = attrifyString(
            preString: "You now have:\n\n", toAttrify: "9", postString: nil, color: myThemeColor)

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        middleButton.setTitleNew(Const.endMessage)
        progressBar.setProgress(1, animated: true)
    }


    @objc func done() {
        navigationController?.popToRootViewController(animated: true)
    }

}
