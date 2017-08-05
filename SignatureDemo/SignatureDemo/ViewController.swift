//
//  ViewController.swift
//  SignatureDemo
//
//  Created by KIEU, HAI on 8/3/17.
//  Copyright © 2017 Kieu, Ngoc Hai. All rights reserved.
//

import UIKit
import Drawing

class ViewController: UIViewController {

    @IBOutlet weak var drawView: BaseDrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onStartOver(_ sender: Any) {
        UIView.transition(with: drawView, duration: 1, options: .transitionCurlUp, animations: { 
            self.drawView.startOver()
        }) { (Bool) in
            
        }   
    }

    @IBAction func onDebugging(_ sender: Any) {
        drawView.debugPath = !drawView.debugPath
    }
    
    @IBAction func onUndo(_ sender: Any) {
        drawView.undo()
    }
    @IBAction func chooseBigPen(_ sender: Any) {
        drawView.thick = min(drawView.thick + 1, 15)
    }
    
    @IBAction func chooseSmallPen(_ sender: Any) {
        drawView.thick = max(drawView.thick - 1, 1)
    }
    @IBAction func chooseBlack(_ sender: Any) {
        drawView.strokeColor = .black
        drawView.fillColor = .black
    }
    @IBAction func chooseBLue(_ sender: Any) {
        drawView.strokeColor = .blue
        drawView.fillColor = .blue
    }
    @IBAction func chooseYellow(_ sender: Any) {
        drawView.strokeColor = .yellow
        drawView.fillColor = .yellow
    }
    @IBAction func chooseRed(_ sender: Any) {
        drawView.strokeColor = .red
        drawView.fillColor = .red
    }
}

