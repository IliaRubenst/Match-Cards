//
//  Card.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 24.08.2023.
//

import UIKit

enum CardStatus {
    case normal
    case open
    case match
}

class Card: NSObject {
    var name: String
    var frontSide: UIImage?
    var backSide: UIImage?
    var status: CardStatus = .normal
    
    var isFlipped: Bool = false
    
    init(name: String, frontSide: UIImage, backSide: UIImage) {
        self.name = name
        self.frontSide = frontSide
        self.backSide = backSide
    }
}
