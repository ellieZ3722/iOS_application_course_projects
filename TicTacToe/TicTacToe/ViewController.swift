//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kiwiinthesky72 on 1/30/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var squares: [UIImageView]!
    
    @IBOutlet var oImage: UIImageView!
    @IBOutlet var xImage: UIImageView!
    
    let xOrig: CGPoint = CGPoint(x: 87, y: 738)
    let oOrig: CGPoint = CGPoint(x: 321, y: 738)
    
    @IBOutlet var OKbutton: UIButton!
    @IBOutlet var notificationContent: UILabel!
    
    @IBOutlet var gridView: GridView!
    @IBOutlet var infoButton: UIButton!
    
    @IBOutlet var infoview: InfoView!
    
    var xTurn: Bool = false
    
    let grid: Grid = Grid()
    
    let rule: String = "Get 3 in a row to win!"
    let XWinText: String = "Congratulations, X wins!"
    let OWinText: String = "Congratulations, O wins!"
    let tieText: String = "It's a tie!"
 
    @IBOutlet var lineAnimationView: UIView!
    
    let duration: CFTimeInterval = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        xImage.image = UIImage(named: "x")
        oImage.image = UIImage(named: "o")
        
        //enable dragging of th two labels
        addGestureToView(view: xImage)
        addGestureToView(view: oImage)
        
        changeTurn()
        
        //setting up the notification content as the introduction of the game
        notificationContent.text = rule
        
        //setting up the action when info button is tapped
        infoButton.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
        
        //setting up the action when OK button is tapped
        OKbutton.addTarget(self, action: #selector(OKButtonTapped(_:)), for: .touchUpInside)
        
        //bring the winning-line-drawing view to front
        self.view.bringSubviewToFront(lineAnimationView)
        
        //bring two labels and the info button to front
        self.view.bringSubviewToFront(infoButton)
        self.view.bringSubviewToFront(xImage)
        self.view.bringSubviewToFront(oImage)
        
        //put the info view to the front
        self.view.bringSubviewToFront(infoview)
        //put this grid view to the back
        self.view.sendSubviewToBack(gridView)
        
        
    }

    func addGestureToView(view: UIImageView) {
        //Pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        //move x and o labels
        case .changed:
            let translation = recognizer.translation(in: self.view);
            
            if let view = recognizer.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            
            recognizer.setTranslation(CGPoint(x: 0,y :0), in: self.view)
        //when labels are released, determine which cell to fill in image
        case .ended:
            
            if let view = recognizer.view {
                for i in 0 ... squares.count - 1 {
                    if squares[i].frame.contains(view.center) && !grid.isOcuppied(index: i) {
                        snapIn(label: view, square: squares[i], index: i)
                        return
                    }
                }
                //return the label to its original position
                returnOriginalPosition(label: view)
            }
            
        default: ()
        }
    }
    
    //function to animate the process of image snapped in cells
    func snapIn(label: UIView, square: UIImageView, index: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            label.center = square.center
        }, completion: { _ in
            if self.xTurn {
                square.image = UIImage(named: "x")
                label.center = self.xOrig
                self.grid.occupy(index: index, type: 1)
            } else {
                square.image = UIImage(named: "o")
                label.center = self.oOrig
                self.grid.occupy(index: index, type: 2)
            }
            self.changeTurn()
        })
    }
    
    //animate the infoview drop down
    @objc func infoButtonTapped(_ button: UIButton) {
        if self.grid.isThereWinner()[0] != -2 {
            clearBoard()
        }
        
        let coor: CGRect = self.infoview.frame
        
        if coor.midY < 0 {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {
                self.infoview.center = CGPoint(x: 207, y: 448)
            })
        } else {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {
                self.infoview.center = CGPoint(x: 207, y: 986)
            }, completion: { _ in
                self.infoview.center = CGPoint(x: 207, y: -90)
                self.notificationContent.text = self.rule
            })
        }
    }
    
    //animate the infoview drop down by ok button click
    @objc func OKButtonTapped(_ button: UIButton) {
        if self.grid.isThereWinner()[0] != -2 {
            clearBoard()
        }
        
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseIn], animations: {
            self.infoview.center = CGPoint(x: 207, y: 986)
        }, completion: { _ in
            self.infoview.center = CGPoint(x: 207, y: -90)
            self.notificationContent.text = self.rule
        })
    
    }
    
    //function to animate the fade out of nine cells and clear the grid
    func clearBoard() {
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {
            for square in self.squares {
                square.alpha = 0
            }
        }, completion: { _ in
            self.squaresClear()
            self.grid.clear()
            for square in self.squares {
                square.alpha = 1
            }
            
            self.xTurn = true
            self.xImage.alpha = 1
            self.oImage.alpha = 0.5
            self.oImage.isUserInteractionEnabled = false
            self.xImage.isUserInteractionEnabled = true
            
            self.animating(view: self.xImage)
        })
    }
    
    //sending down the won notification
    func wonNotification(type: Int) {

        lineAnimationView.layer.sublayers = nil
        
        if type == 1 {
            notificationContent.text = XWinText
        } else if type == 2 {
            notificationContent.text = OWinText
        } else {
            notificationContent.text = tieText
        }
        
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {
            self.infoview.center = CGPoint(x: 207, y: 448)
        })
    }
    
    //clear the nine imageviews
    func squaresClear() {
        for imgview in squares {
            imgview.image = nil
        }
    }
    
    //check if there is a winner after one side completes its step
    //if there is a winner, call draw line function and the won notification function
    //if there is no winner, change the right to play to the other side
    func changeTurn() {
        let winnerState = grid.isThereWinner()
        
        if winnerState[0] == 1 {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.wonNotification(type: 1)
            })
            drawLineAfterWin(winnerState: winnerState)
            CATransaction.commit()
            
        } else if winnerState[0] == 2 {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.wonNotification(type: 2)
            })
            drawLineAfterWin(winnerState: winnerState)
            CATransaction.commit()
            
        } else if winnerState[0] == -1 {
            wonNotification(type: 4)
        } else {
            if xTurn {
                self.xTurn = false
                self.xImage.alpha = 0.5
                xImage.isUserInteractionEnabled = false
                oImage.isUserInteractionEnabled = true
                self.oImage.alpha = 1
                
                animating(view: oImage)
                
            } else {
                self.xTurn = true
                self.xImage.alpha = 1
                self.oImage.alpha = 0.5
                oImage.isUserInteractionEnabled = false
                xImage.isUserInteractionEnabled = true
                
                animating(view: xImage)
            }
        }
    }
    
    //animating the process of labels returning to the original positions
    func returnOriginalPosition(label: UIView) {
        if xTurn {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {
                label.center = self.xOrig
            })
        } else {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {
                label.center = self.oOrig
            })
        }
    }
    
    //animation to notify which side to play
    func animating(view: UIView) {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }

        animator.addAnimations {
            view.alpha = 0
        }
        
        animator.addCompletion { _ in
            view.transform = .identity
            view.alpha = 1
        }
            
        animator.startAnimation()

    }
    
    //when a winner appears, the function animates the line drawing action
    func drawLineAfterWin(winnerState: [Int]) {
        let square1 = winnerState[1] - 1
        let square2 = winnerState[2] - 1
        
        lineAnimationView.layer.sublayers = nil
        
        let line = UIBezierPath()
        line.move(to: squares[square1].center)
        line.addLine(to: squares[square2].center)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = line.cgPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineCap = .round
        
        let strokeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = 1
        strokeAnimation.duration = duration
        
        shapeLayer.add(strokeAnimation, forKey: nil)
        
        lineAnimationView.layer.addSublayer(shapeLayer)
    }
}


