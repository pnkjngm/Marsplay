//
//  Utility.swift
//  Marsplay
//
//  Created by Pankaj Kumar Nigam on 12/01/20.
//  Copyright © 2020 Pankaj Kumar Nigam. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Corner Radius for View
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
