//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Daniele Vitali on 10/31/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}