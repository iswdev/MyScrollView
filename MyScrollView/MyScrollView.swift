//
//  MyScrollView.swift
//  MyScrollView
//
//  Created by Francisco on 2018-10-17.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

@IBDesignable
class MyScrollView: UIView {
    
    var contentSize = CGSize()
    
    var maxScrollWidth : CGFloat = 0.0
    var maxScrollHeight : CGFloat  = 0.0
    var minScrollWidth : CGFloat = 0.0
    var minScrollHeight : CGFloat  = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentSize = CGSize(width: frame.width, height: frame.height)
        clipsToBounds = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
        calcScrollBounds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setScrollBounds(_ view: UIView){
        // calculate a max width and height using the component max
        maxScrollWidth = max(maxScrollWidth, view.frame.origin.x + view.frame.width + 10)
        maxScrollHeight = max(maxScrollHeight, view.frame.origin.y + view.frame.height + 10)
        
        minScrollHeight = min(minScrollHeight, view.frame.origin.x)
        minScrollWidth = min(minScrollWidth, view.frame.origin.y)
        
    }
    
    // override addSubview to recalculate max scroll bounds
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        calcScrollBounds()
    }
    
    // to calculate the max x and y bounds to scroll
    func calcScrollBounds(){
        maxScrollWidth = 0
        maxScrollHeight = 0
        minScrollWidth = 0
        minScrollHeight = 0
        
        setScrollBounds(self)
        
        for view in subviews {
            setScrollBounds(view)
        }
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
        
        // set new position
        self.bounds.origin.x -= translation.x
        self.bounds.origin.y -= translation.y
        
        // save new position
        var newx = self.bounds.origin.x
        var newy = self.bounds.origin.y
        
        // check right bound
        if (contentSize.width + newx > maxScrollWidth){
            newx = self.maxScrollWidth - contentSize.width
        }
        // check bottom bound
        if (contentSize.height + newy > maxScrollHeight){
            newy = self.maxScrollHeight - contentSize.height
        }
        
        // check left bound
        if (newx < minScrollWidth){
            newx = minScrollWidth
        }
        // check top bound
        if (newy < minScrollHeight){
            newy = minScrollHeight
        }
        
        // animate transition
        UIView.animate(withDuration: 0.2, animations: {
            self.bounds.origin.x = (newx)
            self.bounds.origin.y = (newy)
        })
    }
    
    
}
