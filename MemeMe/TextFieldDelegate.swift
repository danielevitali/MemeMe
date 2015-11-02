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
    
    let emptyStringPlaceholder: String
    
    init(placeholder: String) {
        emptyStringPlaceholder = placeholder
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text == "" {
            textField.text = emptyStringPlaceholder
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let uppercaseString = string.uppercaseString
        if uppercaseString != string {
            if let text = textField.text {
                textField.text = text + uppercaseString
            } else {
                textField.text = uppercaseString
            }
            return false
        }
        return true
    }
    
}