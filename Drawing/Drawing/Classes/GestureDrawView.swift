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
    
    public override func startOver() {
        super.startOver()
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
            return
        case .changed:
            path.append(newPoint)
            refresh()
            return
            
        case .ended:
            paths.append(path)
            refresh()
            return
            
        case .cancelled,.failed:
            fallthrough
        default:
            path.removeAll()
            refresh()
            return
        }
    }
}
