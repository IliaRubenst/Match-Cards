//
//  CardCell.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 24.08.2023.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet var fontImage: UIImageView!
    @IBOutlet var backImage: UIImageView!
    
    var counter = 0
    
    func configure(with cardModel: Card) {
        backImage.image = cardModel.backSide
        fontImage.image = cardModel.frontSide
        
        backImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        backImage.layer.borderWidth = 2
        backImage.layer.cornerRadius = 3
        layer.cornerRadius = 5

        fontImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        fontImage.layer.borderWidth = 2
        fontImage.layer.cornerRadius = 3
        layer.cornerRadius = 5
    }

    func flipCard(_ cardModel: Card) {
        let isFlipped = cardModel.isFlipped
        let sourceView = isFlipped ? fontImage : backImage
        let targetView = isFlipped ? backImage : fontImage
        
        let flipDirection: UIView.AnimationOptions = isFlipped ? .transitionFlipFromRight : .transitionFlipFromLeft
        let option: UIView.AnimationOptions = [flipDirection, .showHideTransitionViews]
        
        if cardModel.status == .normal {
            UIView.transition(from: sourceView!, to: targetView!, duration: 0.8, options: option)
        }
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            let flipDirection: UIView.AnimationOptions = .transitionFlipFromLeft
            let option: UIView.AnimationOptions = [flipDirection, .showHideTransitionViews]
            
            UIView.transition(from: fontImage, to: backImage, duration: 0.8, options: option)
        }
    }
    
    func removeCell() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [self] in
            UIView.animate(withDuration: 0.8) {
                self.backImage.frame = CGRect(x: 45, y: 45, width: 1, height: 1)
                self.fontImage.frame = CGRect(x: 45, y: 45, width: 1, height: 1)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) { [self] in
            backImage.alpha = 0
            fontImage.alpha = 0
        }
    }
}
