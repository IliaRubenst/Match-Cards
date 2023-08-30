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
    var card = ViewController()
    
    var counter = 0

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
            backImage.alpha = 0
            fontImage.alpha = 0
        }
    }
    
    func newGameReset() {
        backImage.alpha = 1
        fontImage.alpha = 1
    }
}
