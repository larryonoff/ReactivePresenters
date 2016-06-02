//
//  UITextField.swift
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

extension UITextField {
    public var rxp_text: Presenter<String?> {
        return Presenter { [weak self] in
            self?.text = $0
            
            return nil
        }
    }
    
    public var rxp_textDidChange: Presenter<(String) -> Void> {
        return Presenter { [weak self] sink in
            guard let strongSelf = self else {
                return nil
            }
            
            return NSNotificationCenter
                .defaultCenter()
                .rac_notifications(UITextFieldTextDidChangeNotification, object: strongSelf)
                .map { notification in
                    let textField = notification.object as? UITextField
                    return textField?.text ?? ""
                }
                .startWithNext(sink)
        }
    }
    
    public var rxp_placeholder: Presenter<String?> {
        return Presenter { [weak self] in
            self?.placeholder = $0
            
            return nil
        }
    }
}
    
#endif