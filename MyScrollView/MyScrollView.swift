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
    
    @IBInspectable
    var contentSize : CGSize = CGSize() {
        didSet {
            frame.size = contentSize
        }
    }
    
   
    override func willMove(toWindow newWindow: UIWindow?) {
       print("View appear")
    }
    
    func handleTranslation(translation: CGPoint){
        
        let screenSize = UIScreen.main.bounds
        
        // move using translation coordinates
        self.center = CGPoint(x:self.center.x + translation.x,
                              y:self.center.y + translation.y)
        
        var newx = self.frame.origin.x
        var newy = self.frame.origin.y
        
        // check right bound
        if (screenSize.width - newx > contentSize.width){
            newx = screenSize.width - self.contentSize.width
        }
        // check bottom bound
        if (screenSize.height - newy > contentSize.height){
            newy = screenSize.height - self.contentSize.height
        }
        
        // check left bound
        if (newx > 0){
            newx = 0
        }
        // check top bound
        if (newy > 0){
            newy = 0
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.frame.origin.x = newx
            self.frame.origin.y = newy
        })
        
        
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
