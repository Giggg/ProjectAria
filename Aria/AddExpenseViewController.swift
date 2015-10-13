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
    
    @IBOutlet weak var amount_txt: UITextField!
    @IBOutlet weak var result_label: UILabel!
    @IBOutlet weak var velocity_result_label: UILabel!
    @IBOutlet weak var delete_btn: UIButton!
    @IBOutlet weak var sprmkt_txt_btn: UIButton!
    @IBOutlet weak var transporation_btn: UIButton!
    @IBOutlet weak var health_and_beauty_btn: UIButton!
    @IBOutlet weak var enterttainment_btn: UIButton!
    @IBOutlet weak var shopping_and_gifts_btn: UIButton!
    @IBOutlet weak var bills_and_rent_btn: UIButton!

    
    @IBAction func enterttainmentPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
        amount_txt.text = ""
        updateResults()
        
    }
    
    @IBAction func bills_and_rentPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
        self.view.endEditing(true)
        amount_txt.text = ""
        updateResults()
        
    }
    
    
    @IBAction func shopping_and_giftsPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
        amount_txt.text = ""
        updateResults()
        
    }
    
    @IBAction func health_and_beautyPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
        amount_txt.text = ""
        updateResults()
        
    }
    
    
    @IBAction func sprmktPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
        amount_txt.text = ""
        updateResults()
       
    }
    
    @IBAction func transportationPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text! as NSString).doubleValue, InCategory: Category.Fuel)
        
        amount_txt.text = ""
        updateResults()
        
    }

    @IBAction func deletePressed(sender: AnyObject) {
        sharedDBManager.clearDB()
        updateResults()
    }
    
    func updateResults () {
        result_label.text = String (format:"%f", sharedStatusModel.getTotalExpense())
        velocity_result_label.text = String (format:"%f", sharedStatusModel.getVelocity())
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amount_txt.delegate = self
        
        //http://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
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
    
    /*
    func textFieldShouldEndEditing(test_txt: UITextField) -> Bool {
        return true
    }
*/
}
