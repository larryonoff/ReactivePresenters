//
//  UIControl.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 02/06/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
import Foundation
import UIKit
import ReactiveCocoa
import ReactivePresenters

private final class ControlTarget: NSObject {
    typealias Control = UIControl
    typealias Callback = () -> Void
    
    private let selector: Selector = #selector(eventHandler(_:))
    
    private let callback: Callback
    
    init(_ callback: Callback) {
        self.callback = callback
    }
    
    @objc func eventHandler(sender: Control) {
        callback()
    }
}

extension UIControl {
    public var rxp_enabled: Presenter<Bool> {
        return Presenter { [weak self] in
            self?.enabled = $0
            
            return nil
        }
    }
    
    public var rxp_selected: Presenter<Bool> {
        return Presenter { [weak self] in
            self?.selected = $0
            
            return nil
        }
    }
    
    public func rxp_event(controlEvents: UIControlEvents) -> Presenter<() -> Void> {
        return Presenter { [weak self] action in
            let target = ControlTarget(action)
            
            self?.addTarget(target, action: target.selector, forControlEvents: controlEvents)
            
            return ActionDisposable {
                self?.removeTarget(target, action: target.selector, forControlEvents: controlEvents)
            }
        }
    }
}
    
#endif