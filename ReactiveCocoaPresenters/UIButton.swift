//
//  UIButton.swift
//  ReactivePresenters
//
//  Created by Ilya Laryionau on 02/06/16.
//  Copyright © 2016 Ilya Laryionau. All rights reserved.
//

import Foundation

#if os(iOS)
    
import Foundation
import ReactiveCocoa
import ReactivePresenters
import UIKit

extension UIButton {
    public var rxp_tap: Presenter<() -> Void> {
        return rxp_event(.TouchUpInside)
    }
    
    public func rxp_title(state: UIControlState) -> Presenter<String?> {
        return Presenter { [weak self] in
            self?.setTitle($0, forState: state)
            
            return nil
        }
    }
}
    
#endif