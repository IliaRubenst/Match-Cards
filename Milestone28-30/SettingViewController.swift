//
//  SettingViewController.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 28.08.2023.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    @IBOutlet var background: UIImageView!
    
    var viewController = ViewController()
    var cardAmount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = UIImage(named: "background")
        
        mainLabel.text = "Choose difficultу"
        mainLabel.textColor = .white
        mainLabel.backgroundColor = .systemBlue
        mainLabel.layer.masksToBounds = true
        mainLabel.layer.cornerRadius = 7
        
        firstButton.setTitle("Easy", for: .normal)
        firstButton.tintColor = .white
        firstButton.backgroundColor = .systemBlue
        firstButton.layer.cornerRadius = 7
        
        secondButton.setTitle("Normal", for: .normal)
        secondButton.tintColor = .white
        secondButton.backgroundColor = .systemBlue
        secondButton.layer.cornerRadius = 7
        
        thirdButton.setTitle("Hard", for: .normal)
        thirdButton.tintColor = .white
        thirdButton.backgroundColor = .systemBlue
        thirdButton.layer.cornerRadius = 7
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func firstButtonAction(_ sender: UIButton) {
        cardAmount = 6
        
        goGame()
    }
    @IBAction func secondButtonAction(_ sender: UIButton) {
        cardAmount = 10

        goGame()
    }
    @IBAction func thirdButtonAction(_ sender: UIButton) {
        cardAmount = 14

        goGame()
    }
    
    func goGame() {
        if let gameVC = self.storyboard?.instantiateViewController(identifier: "Game") as? ViewController {
            gameVC.modalPresentationStyle = .fullScreen
            gameVC.cardsAmount = cardAmount
            navigationController?.pushViewController(gameVC, animated: true)
        }
    }
}
