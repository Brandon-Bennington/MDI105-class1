//
//  api.swift
//  MDI105-class1
//
//  Created by Brandon Bennington on 11/08/25.
//

// api.swift
// MDI105-class1

import SwiftUI

enum API {
    static func getBooks() -> [Book] {
        return [
            Book(title:"The Fellowship of the Ring", image:"LOTR_Fellowship", description:"In a sleepy village in the Shire, a young hobbit is entrusted with an immense task. He must make a perilous journey across Middle-earth to the Cracks of Doom, there to destroy the Ruling Ring of Power - the only thing that prevents the Dark Lord's evil dominion. Join Frodo and the Fellowship as they begin their epic quest filled with danger, friendship, and the weight of destiny."),
            Book(title:"The Two Towers", image:"LOTR_TwoTowers", description:"The Fellowship has broken. Frodo and Sam continue their dangerous journey toward Mordor, guided by the treacherous Gollum. Meanwhile, Aragorn, Legolas, and Gimli pursue the Uruk-hai who captured Merry and Pippin. As the forces of darkness gather, the fate of Middle-earth hangs in the balance, and the true test of courage and loyalty begins."),
            Book(title:"The Return of the King", image:"LOTR_ReturnOfTheKing", description:"The final volume of the epic trilogy brings the War of the Ring to its climactic conclusion. As Frodo and Sam approach Mount Doom on their final desperate mission to destroy the Ring, Aragorn must claim his destiny as the rightful king. The greatest battle for Middle-earth is about to begin, where heroes will be tested and the fate of all free peoples will be decided.")
        ]
    }
}

