//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dave Jung on 2021/01/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.theme.nameOfThemes).bold()
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 1)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 2)) {
                    self.viewModel.newGame()
                }
            }, label: { Text("New Game")} )
            Text("score is \(viewModel.score)")
        }

    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedTimeRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedTimeRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedTimeRemaining = 0
        }
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedTimeRemaining*360-90), clockwise: true)
                                .onAppear {
                                    self.startBonusTimeAnimation()
                                }
                        }
                        else {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 0.6).repeatForever(autoreverses: false) : .default )
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
//                    .aspectRatio(2/3, contentMode: .fit
            }

        }
    }
}
    //MARK: - Cardify (ViewModifier)
    struct Cardify: AnimatableModifier {
        
        var rotation: Double
        var isFaceUp: Bool {
            rotation < 90
        }
        var animatableData: Double {
            get {
                return rotation
            }
            set {
                rotation = newValue
            }
        }
        
        init(isFaceUp: Bool) {
            rotation = isFaceUp ? 0 : 180
        }
        
        
        func body(content: Content) -> some View {
            ZStack {
                Group {
                    RoundedRectangle(cornerRadius: cornderRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornderRadius).stroke(lineWidth:edgeLineWidth)
                    content
                }
                    .opacity(isFaceUp ? 1 : 0)
                RoundedRectangle(cornerRadius: cornderRadius).fill()
                    .opacity(isFaceUp ? 0 : 1)
            }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        }
        private let cornderRadius: CGFloat = 10.0
        private let edgeLineWidth: CGFloat = 3
    }
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

    //MARK: - Drawing Constants
    

    private let fontScaleFactor: CGFloat = 0.65
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
