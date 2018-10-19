//
//  MyScrollView.swift
//  MyScrollView
//
//  Created by Francisco on 2018-10-17.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

//@IBDesignable
class MyScrollView: UIView {
    
    //    @IBInspectable
    var contentSize = CGSize()
    var maxWidth : CGFloat = 0.0
    var maxHeight : CGFloat  = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentSize = CGSize(width: frame.width, height: frame.height)
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        maxWidth = max(maxWidth, view.frame.origin.x + view.frame.width + 50)
        maxHeight = max(maxHeight, view.frame.origin.y + view.frame.height + 50)
    }
    
    @objc func handleTap(recognizer:UIPanGestureRecognizer) {
        print("Tap")
        
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        if let view = recognizer.view  {
            let scrollView = view as! MyScrollView
            scrollView.handleTranslation(translation: translation)
        }
        recognizer.setTranslation(CGPoint.zero, in: self)
    }
    
    func handleTranslation(translation: CGPoint){
        
        let viewSize = self.bounds
        
        let originX = self.bounds.origin.x
        let originY = self.bounds.origin.y
        
        // move using translation coordinates
        self.bounds.origin.x -= translation.x
        self.bounds.origin.y -= translation.y
        
        var newx = self.bounds.origin.x
        var newy = self.bounds.origin.y
        
        // check right bound
        print("CUR", newx, viewSize.width, maxWidth)
        if (viewSize.width + newx > maxWidth){
            newx = self.maxWidth - viewSize.width
            print("NEW", newx, viewSize.width, maxWidth)
        }
        // check bottom bound
        if (viewSize.height + newy > maxHeight){
            newy = self.maxHeight - viewSize.height 
        }
        
        // check left bound
        if (newx < 0){
            newx = 0
        }
        // check top bound
        if (newy < 0){
            newy = 0
        }
        
        //UIView.animate(withDuration: 0.1, animations: {
        
        
        self.bounds.origin.x += (newx - originX) / 2
        self.bounds.origin.y += (newy - originY) / 2
        
    }
    
    
    
    
    func autoScroll(amount: CGFloat, step: CGFloat){
        self.frame.origin.y -= step
        if (amount == 0) {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
            self.autoScroll(amount: amount - 1, step: step)
        }
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
