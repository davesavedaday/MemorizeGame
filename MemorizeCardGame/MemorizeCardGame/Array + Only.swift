//
//  Array + Only.swift
//  MemorizeCardGame
//
//  Created by Dave Jung on 2021/01/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
