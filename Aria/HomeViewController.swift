//
//  AddExpenseViewController.swift
//  Aria
//
//  Created by Guy Harpak on 4/22/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import Foundation
import UIKit

class AddExpenseViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var result_label: UILabel!
    @IBOutlet weak var velocity_result_label: UILabel!
    @IBOutlet weak var delete_btn: UIButton!

    @IBAction func deletePressed(sender: AnyObject) {
        sharedDBManager.clearDB()
        updateResults()
    }
    
    func updateResults () {
        result_label.text = String (format:"%f", sharedStatusModel.getTotalExpense())
        velocity_result_label.text = String (format:"%f", sharedStatusModel.getVelocity())
    }
   
    override func viewDidAppear(animated: Bool) {
        updateResults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    
    /*
    //http://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
   
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }

    func textFieldShouldReturn(test_txt: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    */

}
