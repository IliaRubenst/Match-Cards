//
//  ViewController.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 23.08.2023.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var cards = [Card]()
    
    let countCells = 4
    let offSet: CGFloat = 4.0
    var cardsAmount: Int!
    var openCard = String()
    var match = [Int]()
    var openCardCell = [CardCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGameCards()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", image: nil, target: self, action: #selector(newGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset cards", style: .plain, target: self, action: #selector(createGameCards))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        
        let spacing = CGFloat((countCells + 2)) * offSet / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offSet * 3))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as? CardCell else {
            fatalError("Unable to dequeue CardCell.")
        }
        cell.backImage.image = cards[indexPath.row].backSide
        cell.fontImage.image = cards[indexPath.row].frontSide
        
        cell.backImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.backImage.layer.borderWidth = 2
        cell.backImage.layer.cornerRadius = 3
        cell.layer.cornerRadius = 5

        cell.fontImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.fontImage.layer.borderWidth = 2
        cell.fontImage.layer.cornerRadius = 3
        cell.layer.cornerRadius = 5
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if openCardCell.count < 2 && cards[indexPath.item].status == .normal {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        openCardCell.append(cell)
            let path = cards[indexPath.item]
            
            
            path.status = .open
            
            pressCard(indexPath: indexPath)
            path.change()
            setBackSide()
            matchBothSide()
            allMatch()
        }
    }
    
    @objc func createGameCards() {
        loadImage()
        var cutShuffledCards = Array(cards[0 ..< cardsAmount])
        cutShuffledCards.forEach {
            cutShuffledCards.append(Card(name: $0.name, frontSide: $0.frontSide!, backSide: $0.backSide!))
        }
        
        cards = cutShuffledCards.shuffled()
        openCard.removeAll()
        openCardCell.removeAll()
        collectionView.reloadData()
    }
    
    func pressCard(indexPath: IndexPath) {
        let nameCardInArray = cards[indexPath.row].name
        let path = cards[indexPath.row]
        
        if path.status == .open && !openCard.contains(nameCardInArray) {
            path.status = .open
            openCard.append(nameCardInArray)
        } else if path.status == .open && openCard.contains(nameCardInArray) {
            for card in cards where card.status == .open {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    card.status = .match
                }
                match.append(1)
            }
            
            openCard.removeAll()
            openCardCell.removeAll()
        }
        
        collectionView.reloadData()
    }

    func setBackSide() {
        if openCard.count >= 72 {
            openCard.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                for card in self.cards where card.status != .match  {
                    card.status = .normal
                    card.backSide = UIImage(named: "question-mark.png")
                    self.openCardCell.removeAll()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func matchBothSide() {
        if match.count >= 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                for card in self.cards where card.status == .match  {
                    card.backSide = UIImage(named: "match-log.png")
                    card.frontSide = UIImage(named: "match-log.png")
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func allMatch() {
        if (match.count / 2) == cardsAmount! {
            let congratulation = UIAlertController(title: "Congratulations", message: "You guess all cards", preferredStyle: .alert)
            
            congratulation.addAction(UIAlertAction(title: "Ты крутой", style: .default) { [weak self] _ in
                self?.newGame()
            })
            present(congratulation, animated: true)
        }
    }
    
    @objc func newGame() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func loadImage() {
        let fm = FileManager.default
        guard let path = Bundle.main.resourcePath else { fatalError("Unable to dequeue CardCell.") }
        var rawCards = [Card]()
        
        if let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                
                if item.range(of: "logo") != nil {
                    let imageName = UUID().uuidString
                    let frontImage = UIImage(named: item)!
                    let backImage = UIImage(named: "question-mark.png")!
                    let card = Card(name: imageName, frontSide: frontImage, backSide: backImage)
                    rawCards.append(card)
                }
            }
            
            cards = rawCards.shuffled()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
