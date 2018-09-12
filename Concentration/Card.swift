//
//  Card.swift
//  Concentration
//
//  Created by Jin You on 9/11/18.
//  Copyright © 2018 Jin You. All rights reserved.
//

import Foundation

struct Card {
    var id: Int
    var isFlipped = false
    var isMatched = false
    
    static var uniqueId = 0
    
    static func getUniqueId() -> Int {
        uniqueId += 1
        return uniqueId
    }
    
    init(){
        self.id = Card.getUniqueId()
    }
}
