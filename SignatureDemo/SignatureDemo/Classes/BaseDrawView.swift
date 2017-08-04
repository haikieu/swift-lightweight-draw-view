//
//  SignatureDemo
//
//  Created by KIEU, HAI on 8/3/17.
//  Copyright © 2017 Kieu, Ngoc Hai. All rights reserved.
//

import Foundation
import UIKit


//Global debug
private let DEBUG = true

open class BaseDrawView : UIView {
    
    ///Enable debugging mode
    open var isDebug = DEBUG
    
    //MARK: - Base properties
    open var strokeColor : UIColor = .black {
        didSet { refresh() }
    }
    open var lineWidth : CGFloat = 5 {
        didSet { refresh() }
    }
    
    //MARK: - Common functions
    open func startOver() { setNeedsDisplay() }
    open func undo() {}
    open func refresh() { setNeedsDisplay() }
    
    //MARK: - Internal functions
    internal func commonInit() {}
    internal func debugInfo(_ string: String) { if isDebug {print(string)}}
}
