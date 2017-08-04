//
//  SignatureDemo
//
//  Created by KIEU, HAI on 8/3/17.
//  Copyright © 2017 Kieu, Ngoc Hai. All rights reserved.
//

import Foundation
import UIKit


public class SimpleDrawView : BaseDrawView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal override func commonInit() {
        self.isMultipleTouchEnabled = false
        self.isExclusiveTouch = true
    }
    
    var originalPoint : CGPoint? = nil
    var fromPoint : CGPoint? = nil
    var toPoint : CGPoint? = nil
    var path = [CGPoint]()
    var paths = [[CGPoint]]()
    
    public override func startOver() {
        super.startOver()
        originalPoint = nil
        fromPoint = nil
        toPoint = nil
        path.removeAll()
        paths.removeAll()
        refresh()
    }
    
    public override func undo() {
        if paths.count > 0 { paths.removeLast() }
        refresh()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugInfo("touchesBegan")
        guard let touch = touches.first else { return }
        let newPoint = touch.preciseLocation(in: self)
        originalPoint = newPoint
        fromPoint = newPoint
        toPoint = newPoint
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugInfo("touchesMoved")
        guard let touch = touches.first else { return }
        let newPoint = touch.preciseLocation(in: self)
        path.append(newPoint)
        refresh()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugInfo("touchesEnded")
        originalPoint = nil
        fromPoint = nil
        toPoint = nil
        paths.append(path)
        path.removeAll()
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugInfo("touchesCancelled")
        originalPoint = nil
        fromPoint = nil
        toPoint = nil
        path.removeAll()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        for path in paths { drawPath(path) }
        drawPath(path)
    }
    
    private func drawPath(_ path: [CGPoint]) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        if path.count > 1 {
            ctx.move(to: path.first!)
            ctx.addLines(between: path)
            ctx.setStrokeColor(strokeColor.cgColor)
            ctx.setLineWidth(lineWidth)
            ctx.strokePath()
        }
    }
}
