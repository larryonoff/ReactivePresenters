//
//  UIBarButton.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 02/06/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

#if os(iOS)
    
import Foundation
import ReactiveCocoa
import ReactivePresenters
import UIKit

private class BarButtonItemTarget: NSObject {
    typealias Callback = () -> ()
    
    let selector: Selector = #selector(eventHandler(_:))
    
    let callback: Callback
    
    init(callback: Callback) {
        self.callback = callback
    }
    
    @objc func eventHandler(sender: UIBarButtonItem) {
        callback()
    }
}

extension UIBarButtonItem {
    
    public var rxp_enabled: Presenter<Bool> {
        return Presenter { [weak self] in
            self?.enabled = $0
            
            return nil
        }
    }
    
    public var rxp_title: Presenter<String?> {
        return Presenter { [weak self] in
            self?.title = $0
            
            return nil
        }
    }
    
    public var rxp_tap: Presenter<() -> Void> {
        return Presenter { [weak self] sink in
            let target = BarButtonItemTarget(callback: sink)
            
            self?.setTarget(target, action: target.selector)
            
            return ActionDisposable {
                self?.removeTarget(target, action: target.selector)
            }
        }
    }
}

private extension UIBarButtonItem {
    
    private func setTarget(target: AnyObject?, action: Selector) {
        self.target = target
        self.action = action
    }
    
    private func removeTarget(target: AnyObject?, action: Selector) {
        self.target = nil
        self.action = nil
    }
}
    
#endif