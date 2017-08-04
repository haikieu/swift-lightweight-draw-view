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
    open func exportImage () -> UIImage? { return takeSnapshotOfView()}
    
    //MARK: - Internal functions
    internal func commonInit() {}
    internal func debugInfo(_ string: String) { if isDebug {print(string)}}
    
    //MARK: - Private functions
    private func takeSnapshotOfView() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: self.frame.size.width, height: self.frame.size.height))
        self.drawHierarchy(in: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
