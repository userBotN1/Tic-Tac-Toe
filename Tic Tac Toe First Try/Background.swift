//  BackgoundInfoChoice.swift
//  Tic Tac Toe First Try
//  Created by Zhaoyang Liu on 1/1/21.
import Foundation
// MARK: - Rule
let ruleText = "Tic-tac-toe is a paper-and-pencil game for two players, X and O, who take turns marking the spaces in a 3×3 grid.\n\nThe player who succeeds in placing three of their marks in a diagonal, horizontal, or vertical row is the winner. \n\nIt is a solved game with a forced draw assuming best play from both players."

// MARK: - History
struct History {
    var symbol: String
    var region: String
    var time: String
    var description: String
    
    init(symbol: String, region: String, time: String, description: String) {
        self.symbol = symbol
        self.region = region
        self.time = time
        self.description = description
        }
}

// MARK: - Detail description
let egyptText = "Games played on three-in-a-row boards can be traced back to ancient Egypt, where such game boards have been found on roofing tiles dating from around 1300 BCE."
    
let romansText = "The most concrete ancient record we have of the game is from the Romans, and the game they referred to as terni lapilli, or three pebbles at a time. \n\nWith this said, the game wasn’t necessarily identical to how we play today. Rather than writing down markings, it’s believed that the Romans would use tokens, pieces, or pebbles, and move them around the grid to represent the different moves."

let englandText = "In the 18th century in England, record of a children’s game close to Tic-Tac-Toe as we know it first appeared. While there isn’t a concrete understanding of what happened next, most likely the game was passed onto American and other international shores via England’s history of colonization and immigration."

let worldwideText = "In 1952, Noughts and Crosses, developed by British computer scientist Sandy Douglas for the EDSAC computer at the University of Cambridge, became one of the first known video games. \n\nToday, Tic-Tac-Toe is played worldwide, so if you find yourself in an airport, drawing up that famous board is a challenge everyone can recognize."
