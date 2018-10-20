//
//  ViewController.swift
//  MyScrollView
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class MyScrollViewController: UIViewController {

    
    var scrollView: MyScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // main View
        createMainView(color: UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha:1.0))
    }
    
    func createMainView( color: UIColor){
        // create main View
        scrollView = MyScrollView(frame: view.frame)
        // tested with a smaller scrollview
        // scrollView = MyScrollView(frame: CGRect(x: 50, y: 60, width: 200, height: 300))
        scrollView.backgroundColor = color
        view.addSubview(scrollView)
        
        
        // add subviews
        addScrollSubView(rect: CGRect(x: 20, y: 20, width: 100, height: 100) , color: .red)
        addScrollSubView(rect: CGRect(x: 150, y: 150, width: 150, height: 200) , color: .green)
        addScrollSubView(rect: CGRect(x: 40, y: 400, width: 200, height: 150) , color: .blue)
        addScrollSubView(rect: CGRect(x: 100, y: 600, width: 180, height: 150) , color: .yellow)
        
    }
    
    
    func addScrollSubView(rect: CGRect, color: UIColor){
        let subView = UIView(frame: rect)
        subView.backgroundColor = color
        scrollView.addSubview(subView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.handleTranslation(translation: CGPoint(x: 0, y: 0))
    }
    


}



