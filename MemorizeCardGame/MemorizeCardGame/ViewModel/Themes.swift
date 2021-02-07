//
//  Themes.swift
//  MemorizeCardGame
//
//  Created by Dave Jung on 2021/01/22.
//

import SwiftUI
 struct Theme: Identifiable{
    var nameOfThemes: String
    var listOfEmojis: [String]
    var color: Color
    var numOfPairs: Int?
    var id: Int
}
    let themes: [Theme] = [
        Theme(nameOfThemes: "Halloween",
              listOfEmojis: ["👻","🎃", "🕷", "💀", "🍭", "🧚‍♂️"],
              color: Color.orange, numOfPairs: 6 ,id: 0),
        Theme(nameOfThemes: "Faces",
              listOfEmojis: ["😀","🥲", "🤪", "🥳", "😎", "🥸"],
              color: Color.yellow, id: 1),
        Theme(nameOfThemes: "Animals",
              listOfEmojis: ["🐶","🐒", "🐠", "🐢", "🦇", "🐧"],
              color: Color.pink, id: 2),
        Theme(nameOfThemes: "Moon",
              listOfEmojis: ["🌚","🌕","🌗","🌓","🌖","🌔"],
              color: Color.blue,numOfPairs: 6 ,id: 3),
        Theme(nameOfThemes: "Fruit",
              listOfEmojis: ["🍏","🥝","🍓","🍉","🍇","🌽"],
              color: Color.green, id: 4),
        Theme(nameOfThemes: "Number",
              listOfEmojis: ["0️⃣","1️⃣","2️⃣","3️⃣","4️⃣","5️⃣"],
              color: Color.black, id: 5)]
