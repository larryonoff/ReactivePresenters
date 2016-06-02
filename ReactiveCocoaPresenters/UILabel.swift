//
//  UILabel.swift
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

extension UILabel {
    public var rxp_text: Presenter<String?> {
        return Presenter { [weak self] in
            self?.text = $0
            
            return nil
        }
    }
    
    public var rxp_attributedText: Presenter<NSAttributedString?> {
        return Presenter { [weak self] in
            self?.attributedText = $0
            
            return nil
        }
    }
}
    
#endif