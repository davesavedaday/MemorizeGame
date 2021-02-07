//
//  Array+Identifiable.swift
//  MemorizeCardGame
//
//  Created by Dave Jung on 2021/01/20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex( matching: Element) -> Int? {
        for index in 0..<self.count {
            if(matching.id == self[index].id) {
                return index
            }
        }
        return nil
    }
    
}
