# Match-Cards

Match Cards is my first pet project made from scratch. It is a simple memory-matching game implemented in Swift, allowing players to practice and improve their memory skills. The game features various cryptocurrency coin logos as card covers and includes multiple difficulty levels.

### Technologies Used:

- Swift Programming Language:
    Match Cards Game is developed using the Swift programming language, which is native to iOS development.
- FileManager:
    FileManager is utilized for handling file-related operations, specifically for loading images from the app's resources.
- UICollectionView:
    CollectionView is employed to create a grid-based layout for displaying the game cards efficiently.
- Storyboard:
    The project is designed and implemented utilizing Storyboard.
- Basic Animation:
    Basic animations are integrated to provide a visually appealing experience when flipping, removing, and matching cards.
- Custom NSObject (Card Class):
    A custom NSObject class named 'Card' is created to represent the attributes and behavior of each card in the game.
- Grand Central Dispatch (GCD):
    GCD is utilized for handling asynchronous tasks, ensuring smooth gameplay transitions, responsiveness, and managing animations, including the delayed start of specific animations.

### Key Components:

- Card and CardCell Classes:
    The Card class encapsulates the properties of a card, including its name, front and back images, and status. Instances of this class represent individual cards in the game.
    The CardCell class, a subclass of UICollectionViewCell, manages the visual representation and animations of each card on the game board.

- SettingViewController:
    SettingViewController presents a UI where the player can choose the difficulty level of the game. It includes buttons for easy, normal, and hard levels, allowing users to customize their gaming experience.

- ViewController (Main Game View Controller):
    The main view controller (ViewController) is a UICollectionViewController responsible for handling the game logic, user interactions, and card animations.
    It incorporates features such as card flipping, matching, resetting the game, and presenting a congratulatory message upon successful completion.

- Image Loading:
    The loadImage function utilizes FileManager to fetch and load cryptocurrency coin logos from the app's resource directory, populating the game with diverse card images.
    
- Game Logic:
    The game logic includes functions like pressCard, flipOpenCard, setBackSide, and allMatch. These functions manage the gameplay mechanics, card interactions, and the progression of the game.

![MatchCards](https://github.com/IliaRubenst/Match-Cards/assets/131949404/a52cfa9c-ccfe-42aa-a853-e851de19b980)

