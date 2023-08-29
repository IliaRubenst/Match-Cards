//
//  CardCell.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 24.08.2023.
//

import UIKit

enum CardCellStatus {
    case close
    case open
    case match
}

class CardCell: UICollectionViewCell {
    @IBOutlet var fontImage: UIImageView!
    @IBOutlet var backImage: UIImageView!
    
//    var cellStatus: CardCellStatus = .close
//    
//    func changeCellImage() {
//        if cellStatus == .close {
//            backImage.isHidden = false
//        } else if cellStatus == .open {
//            backImage.isHidden = true
//        } else if cellStatus == .match {
//            backImage.isHidden = true
//            fontImage.isHidden = true
//        }
//    }
}
