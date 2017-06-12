protocol PlayingCard {
    var isFaceDown:Bool { get set }
    var shortName:String { get }
}

struct SuitedCard {
    enum Suit {
        case hearts
        case spades
        case diamonds
        case clubs
    }
    
    enum Value {
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
        case ace
    }
    
    let suit:Suit
    let value:Value
    var isFaceDown:Bool
}

struct Joker: PlayingCard {
    var shortName: String

    var isFaceDown: Bool
    
    var color: Color
    
    init(color: Color, isFaceDown: Bool) {
        self.shortName = "Joker"
        self.isFaceDown = isFaceDown
    }
    
    enum Color {
        case red
        case black
    }
    
    
}

let suits:[SuitedCard.Suit] = [.hearts, .diamonds, .clubs, .spades]
let values:[SuitedCard.Value] = [.two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]

struct Deck {
    var cards:[PlayingCard] = []
    
    
    init() {
        for suit in suits {
            for value in values {
                cards.append(SuitedCard(suit: suit, value: value, isFaceDown: true) as! PlayingCard)
            }
        }
        
        cards.append(Joker(color: .red, isFaceDown: true))
        
        cards.append(Joker(color: .black, isFaceDown: true))
        
        // shuffle()
    }
}

class BlackjackPlayer {
    var hand: [SuitedCard] = []
    
    func playTurn(dealer: Dealer) {
        while(!hasBusted()) {
            // TODO: decide whether to hit or stand
        }
    }
    
    func hit(dealer: Dealer) {
        dealer.hit(dealer: self as! Dealer)
    }
    
    func stand(dealer: Dealer) {
        dealer.stand(dealer: self as! Dealer)
    }
    
    func hasBusted() -> Bool {
        var totalValue = 0
        for card in self.hand {
            totalValue += card.value.hashValue
        }
        if totalValue >= 21 {
            return true
        } else {
            return false
        }
    }
}

class Dealer: BlackjackPlayer {
    var deck = Deck()
    let opponents: [BlackjackPlayer]
    
    var roundNumber = 1
    
    var activeOpponentIndex:Int = 0
    
    init(opponents: [BlackjackPlayer]) {
        self.opponents = opponents
    }
}

let opponents = [BlackjackPlayer(), BlackjackPlayer(), BlackjackPlayer(), BlackjackPlayer()]
let dealer = Dealer(opponents: opponents)

dealer.startGame()
