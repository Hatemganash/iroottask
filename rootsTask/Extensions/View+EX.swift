//
//  View+EX.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius : CGFloat {
        set (newValue) {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    func currentFirstResponder() -> UIResponder? {
            if self.isFirstResponder { return self }
            for subview in subviews {
                if let responder = subview.currentFirstResponder() {
                    return responder
                }
            }
            return nil
        }
}
