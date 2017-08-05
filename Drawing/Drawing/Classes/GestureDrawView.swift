//
//  SignatureDemo
//
//  Created by KIEU, HAI on 8/3/17.
//  Copyright © 2017 Kieu, Ngoc Hai. All rights reserved.
//

import Foundation
import UIKit


public class GestureDrawView : BaseDrawView {
    
    private lazy var gesture : UIPanGestureRecognizer! = {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(handleGesture(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        gesture.requiresExclusiveTouchType = true
        self.addGestureRecognizer(gesture)
        return gesture
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _ = self.gesture //Initialize gesture
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = self.gesture //Initialize gesture
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
    
    @objc private func handleGesture(_ gesture: UIPanGestureRecognizer) {

        let newPoint = gesture.location(in: self)
        
        switch gesture.state {
        case .began:
            originalPoint = newPoint
            fromPoint = newPoint
            toPoint = newPoint
            return
        case .changed:
            fromPoint = toPoint
            toPoint = newPoint
            path.append(newPoint)
            refresh()
            return
            
        case .ended:
            originalPoint = nil
            fromPoint = nil
            toPoint = nil
            paths.append(path)
            refresh()
            return
            
        case .cancelled,.failed:
            fallthrough
        default:
            originalPoint = nil
            fromPoint = nil
            toPoint = nil
            path.removeAll()
            refresh()
            return
        }
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
        }
        ctx.strokePath()
        ctx.flush()
    }
}
