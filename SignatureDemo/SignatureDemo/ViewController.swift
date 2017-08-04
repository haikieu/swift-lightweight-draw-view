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
        drawView.startOver()
    }

    @IBAction func onUndo(_ sender: Any) {
        drawView.undo()
    }
    @IBAction func chooseBigPen(_ sender: Any) {
        drawView.lineWidth = min(drawView.lineWidth + 1, 15)
    }
    
    @IBAction func chooseSmallPen(_ sender: Any) {
        drawView.lineWidth = max(drawView.lineWidth - 1, 1)
    }
    @IBAction func chooseBlack(_ sender: Any) {
        drawView.strokeColor = .black
    }
    @IBAction func chooseBLue(_ sender: Any) {
        drawView.strokeColor = .blue
    }
    @IBAction func chooseYellow(_ sender: Any) {
        drawView.strokeColor = .yellow
    }
    @IBAction func chooseRed(_ sender: Any) {
        drawView.strokeColor = .red
    }
}

