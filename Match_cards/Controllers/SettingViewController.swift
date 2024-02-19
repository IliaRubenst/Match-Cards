//
//  SettingViewController.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 28.08.2023.
//

import UIKit

final class SettingViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var easyButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var HardButton: UIButton!
    @IBOutlet var background: UIImageView!
    
    var viewController = GameViewController()
    var cardAmount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        background.image = UIImage(named: "background")
        
        mainLabel.text = "Choose difficultу"
        mainLabel.textColor = .white
        mainLabel.backgroundColor = .systemBlue
        mainLabel.layer.masksToBounds = true
        mainLabel.layer.cornerRadius = 7
        
        let buttons = [easyButton, normalButton, HardButton]
        buttons.enumerated().forEach { index, button in
            button?.setTitle(["Easy", "Normal", "Hard"][index], for: .normal)
            button?.tintColor = .white
            button?.backgroundColor = .systemBlue
            button?.layer.cornerRadius = 7
        }

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
    
    private func goGame() {
        if let gameVC = self.storyboard?.instantiateViewController(identifier: "Game") as? GameViewController {
            gameVC.modalPresentationStyle = .fullScreen
            gameVC.cardsAmount = cardAmount
            navigationController?.pushViewController(gameVC, animated: true)
        }
    }
}
