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
    open var debugInfo = DEBUG
    open var debugPath = false { didSet { refresh()}}
    
    //MARK: - Base properties
    open var strokeColor : UIColor = .black { didSet { refresh()}}
    open var fillColor : UIColor = .black { didSet { refresh()}}
    open var thick : CGFloat = 5 { didSet { refresh()}}
    
    //MARK: - Common functions
    open func startOver() { setNeedsDisplay() }
    open func undo() {}
    open func refresh() { setNeedsDisplay() }
    open func exportImage () -> UIImage? { return takeSnapshotOfView()}
    
    //MARK: - Internal properties
    internal var path = [CGPoint]()
    internal var paths = [[CGPoint]]()
    
    //MARK: - Internal functions
    internal func commonInit() {}
    internal func debugInfo(_ string: String) { if debugInfo {print(string)}}
    
    //MARK: - Draw handling
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        for path in paths { drawPath(path); debugPath(path) }
        
        drawPath(path)
        debugPath(path)
    }
    
    private func drawPath(_ path: [CGPoint]) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setStrokeColor(strokeColor.cgColor)
        ctx.setFillColor(fillColor.cgColor)
        ctx.setLineWidth(thick)
        
        if path.count > 1 {
            ctx.move(to: path.first!)
            ctx.addLines(between: path)
        }
        ctx.strokePath()
        ctx.fillPath()
        ctx.flush()
    }
    
    private func drawDot(_ path: [CGPoint]) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setStrokeColor(strokeColor.cgColor)
        ctx.setFillColor(fillColor.cgColor)
        ctx.setLineWidth(thick)
        
        for (_, point) in path.enumerated() {
            
            ctx.move(to: point)
            ctx.addEllipse(in: CGRect.init(x: point.x - thick/2, y: point.y - thick/2, width: thick, height: thick))
        }
        ctx.strokePath()
        ctx.fillPath()
        ctx.flush()
        
    }
    
    private func debugPath(_ path: [CGPoint]) {
        guard debugPath else { return }
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setStrokeColor(UIColor.green.withAlphaComponent(0.8).cgColor)
        ctx.setFillColor(UIColor.green.withAlphaComponent(0.8).cgColor)
        ctx.setLineWidth(thick)
        
        for (_, point) in path.enumerated() {
            
            ctx.move(to: point)
            ctx.addEllipse(in: CGRect.init(x: point.x - thick/2, y: point.y - thick/2, width: thick, height: thick))
        }
        
        ctx.strokePath()
        ctx.fillPath()
        ctx.flush()
    }

    //MARK: - Private functions
    private func takeSnapshotOfView() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: self.frame.size.width, height: self.frame.size.height))
        self.drawHierarchy(in: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
