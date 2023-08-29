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
    var isOpen = false
    var status: CardStatus = .normal
    
    init(name: String, frontSide: UIImage, backSide: UIImage) {
        self.name = name
        self.frontSide = frontSide
        self.backSide = backSide
    }
    
    func change() {
        if status == .open {
            backSide = UIImage(named: "match-log.png")
//            print("Changed status to \(status)")
        }
        if status == .match {
            backSide = UIImage(named: "match-log.png")
            frontSide = UIImage(named: "match-log.png")
//            print("Changed status to \(status)")
        }
        if status == .normal {
            backSide = UIImage(named: "question-mark.png")
//            print("Changed status to \(status)")
        }
    }
}
