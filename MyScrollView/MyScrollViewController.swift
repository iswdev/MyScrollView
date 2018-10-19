//
//  ViewController.swift
//  MyScrollView
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class MyScrollViewController: UIViewController , UIGestureRecognizerDelegate {

    
    var gestureRecognizer: UIPanGestureRecognizer!
    var mainView: MyScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get screen size
        //let screenSize = UIScreen.main.bounds
        
        //create main View
        mainView = MyScrollView()
        mainView.contentSize = CGSize(width: 600, height: 800)
        mainView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha:1.0)
        mainView.clipsToBounds = true
        view.addSubview(mainView)
        
        // add gesture recognizer to mainView
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        gestureRecognizer.delegate = self
        mainView.addGestureRecognizer(gestureRecognizer)
        
        // add subviews
        addView(rect: CGRect(x: 20, y: 20, width: 100, height: 100) , color: .red)
        addView(rect: CGRect(x: 150, y: 150, width: 150, height: 200) , color: .green)
        addView(rect: CGRect(x: 40, y: 400, width: 200, height: 150) , color: .blue)
        addView(rect: CGRect(x: 100, y: 600, width: 180, height: 150) , color: .yellow)
        
        
        
    }
    
    func addView(rect: CGRect, color: UIColor){
        let subView = UIView()
        subView.frame = rect
        subView.backgroundColor = color
        mainView.addSubview(subView)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view  {
            let scrollView = view as! MyScrollView
            scrollView.handleTranslation(translation: translation)
            
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }


}



