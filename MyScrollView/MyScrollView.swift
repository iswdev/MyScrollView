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
            self.frame.size = contentSize
        }
    }
    
   
    override func willMove(toWindow newWindow: UIWindow?) {
       print("View appear")
    }
    
    func pan(translation: CGPoint){
        self.center = CGPoint(x:self.center.x + translation.x,
            y:self.center.y + translation.y)
        
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
