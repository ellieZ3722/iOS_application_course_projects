//
//  GridView.swift
//  TicTacToe
//
//  Created by Kiwiinthesky72 on 1/30/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class GridView: UIView {

    
    //Only override draw() if you perform custom drawing.
    //An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        // Draw dashed horizontal lines
        let lines = UIBezierPath()
        
        lines.move(to: CGPoint(x: 0, y: 122))
        lines.addLine(to: CGPoint(x: width, y: 122))
        
        lines.move(to: CGPoint(x: 0, y: 249))
        lines.addLine(to: CGPoint(x: width, y: 249))
        
        lines.move(to: CGPoint(x: 122, y: 0))
        lines.addLine(to: CGPoint(x: 122, y: height))
        
        lines.move(to: CGPoint(x: 249, y: 0))
        lines.addLine(to: CGPoint(x: 249, y: height))
        
        lines.lineWidth = 10
        UIColor.purple.setStroke()
        lines.stroke()
    }
    
    
    
}
