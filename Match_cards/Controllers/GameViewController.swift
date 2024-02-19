//
//  ViewController.swift
//  Milestone28-30
//
//  Created by Ilia Ilia on 23.08.2023.
//

import UIKit

final class GameViewController: UICollectionViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {

    let amountCells = 4
    let offSet: CGFloat = 4.0
    var cardsAmount: Int!
    var cards = [Card]()
    var openCard = String()
    var match = [Int]()
    var openCardCell = [CardCell]()
    var cellCounter: Int!
    var firstOpenCardIndex: IndexPath?    
    
    var scoreLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.font = UIFont.boldSystemFont(ofSize: 38)
         return label
     }()
    
    var score: Int = 0 {
        didSet {
            updateScoreLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGameCards()
        configureScoreLabel(with: scoreLabel)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", image: nil, target: self, action: #selector(newGame))
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(amountCells)
        let heightCell = widthCell
        let spacing = CGFloat((amountCells + 2)) * offSet / CGFloat(amountCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offSet * 3))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as? CardCell else {
            fatalError("Unable to dequeue CardCell.")
        }
        let card = cards[indexPath.row]
        cell.configure(with: card)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if openCardCell.count < 2 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
            let path = cards[indexPath.row]
            openCardCell.append(cell)
            cell.counter = openCardCell.count
            
            if !path.isFlipped && path.status != .match {
                cell.flipCard(path)
                path.flip()
                
                if firstOpenCardIndex == nil {
                    firstOpenCardIndex = indexPath
                } else {
                    flipOpenCard(indexPath)
                }
            }
            
            path.updateStatus(to: .open)
            pressCard(indexPath: indexPath)
            setBackSide()
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
    
    @objc func newGame() { _ = navigationController?.popToRootViewController(animated: true) }
    
    private func flipOpenCard(_ secondOpenCardIndex: IndexPath) {
        let cardOne = cards[firstOpenCardIndex!.row]
        let cardTwo = cards[secondOpenCardIndex.row]
        
        let cardOneCell = collectionView.cellForItem(at: firstOpenCardIndex!) as? CardCell
        let cardTwoCell = collectionView.cellForItem(at: secondOpenCardIndex) as? CardCell
        
        if cardOne.frontSide == cardTwo.frontSide {
            cardOne.status = .match
            cardTwo.status = .match
            match.append(1)
            
            cardOneCell?.removeCell()
            cardTwoCell?.removeCell()
            
            updateScore(by: 2)
        } else {
            cardOne.flip()
            cardTwo.flip()
            cardOne.updateStatus(to: .normal)
            cardTwo.updateStatus(to: .normal)
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            updateScore(by: -1)
        }
        
        firstOpenCardIndex = nil
    }
    
    private func pressCard(indexPath: IndexPath) {
        let nameCardInArray = cards[indexPath.row].name
        let path = cards[indexPath.row]
        
        if path.status == .open && !openCard.contains(nameCardInArray) {
            path.status = .open
            openCard.append(nameCardInArray)
        } else if path.status == .open && openCard.contains(nameCardInArray) {
            openCard.removeAll()
            openCardCell.removeAll()
        }
    }

    private func setBackSide() {
        if openCard.count >= 72 {
            cellCounter = 2
            openCard.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                for card in self.cards where card.status != .match  {
                    card.status = .normal
                    self.openCardCell.removeAll()
                }
            }
        }
    }
    
    private func allMatch() {
        if match.count == cardsAmount! {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) { [self] in
                let congratulation = UIAlertController(title: "Congratulations!", message: "You guessed all cards", preferredStyle: .alert)
                
                congratulation.addAction(UIAlertAction(title: "You are awesome", style: .default) { [weak self] _ in
                    self?.newGame()
                })
                present(congratulation, animated: true)
            }
        }
    }
    
    private func loadImage() {
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
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func configureScoreLabel(with label: UILabel) {
        view.addSubview(scoreLabel)
        
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.systemBlue
        ]
        
        let attributedString = NSAttributedString(string:  "Score: 0", attributes: attributes)
        scoreLabel.attributedText = attributedString
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func updateScoreLabel() { scoreLabel.text = "Score: \(score)" }
    
    private func updateScore(by value: Int) {
        score += value
        updateScoreLabel()
    }
}
