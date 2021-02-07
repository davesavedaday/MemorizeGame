//
//  EmojiMemoryGame.swift
//  MemorizeCardGame
//
//  Created by Dave Jung on 2021/01/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    var theme = themes.randomElement()!
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    private static func createMemoryGame (theme: Theme) -> MemoryGame<String> {
        let emojis = theme.listOfEmojis
        return MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
            return emojis[pairIndex]
        }
    }
    //MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var score: Int {
        model.score
    }
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    func newGame() {
        let newTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
        theme = newTheme
    }
    
}
