//
//  Grid.swift
//  TicTacToe
//
//  Created by Kiwiinthesky72 on 2/2/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import Foundation

class Grid {
    var board: [[Int]] = []
    
    init () {
        for _ in 0...2 {
            var row: [Int] = []
            for _ in 0...2 {
                row.append(0)
            }
            board.append(row)
        }
    }
    
    func occupy(index: Int, type: Int) {
        let col = index % 3
        let row = index / 3
        
        board[row][col] = type
    }
    
    func isOcuppied(index: Int) -> Bool {
        let col = index % 3
        let row = index / 3
        
        return board[row][col] != 0
    }
    
    func isThereWinner() -> [Int] {
        //check rows
        for i in 0...2 {
            let first = board[i][0]
            if first == 0 {
                continue
            }
            if board[i][1] == first && board[i][2] == first {
                return [first, i * 3 + 1, i * 3 + 3]
            }
        }
        
        //check cols
        for i in 0...2 {
            let first = board[0][i]
            if first == 0 {
                continue
            }
            if board[1][i] == first && board[2][i] == first {
                return [first, i + 1, 7 + i]
            }
        }
        
        //check diagnals
        var first = board[0][0]
        if first != 0 && board[1][1] == first && board[2][2] == first {
            return [first, 1, 9]
        }
        first = board[0][2]
        if first != 0 && board[1][1] == first && board[2][0] == first {
            return [first, 3, 7]
        }
        
        //no winner
        if isTie() {
            return [-1]
        }
        return [-2]
    }
    
    func isTie() -> Bool {
        for i in 0...2 {
            for j in 0...2 {
                if board[i][j] == 0 {
                    return false;
                }
            }
        }
        
        return true
    }
    
    func clear() {
        for i in 0...2 {
            for j in 0...2 {
                board[i][j] = 0
            }
        }
    }
}
