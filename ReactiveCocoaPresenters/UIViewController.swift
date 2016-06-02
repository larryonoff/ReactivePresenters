//
//  UIViewController.swift
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

extension UIViewController {
    public var rxp_title: Presenter<String?> {
        return Presenter { [weak self] in
            self?.title = $0
            
            return nil
        }
    }
}

#endif