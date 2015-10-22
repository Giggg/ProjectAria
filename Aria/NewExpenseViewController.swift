//
//  NewExpenseViewController.swift
//  Aria
//
//  Created by Nir Horesh on 19/10/2015.
//  Copyright © 2015 OnBudget. All rights reserved.
//

import Foundation
import UIKit

class NewExpenseViewController: UIViewController {
    @IBOutlet weak var newAmountTxt: UITextField!
    @IBOutlet weak var health_and_beauty_btn: UIButton!
    @IBOutlet weak var rent_and_bills_btn: UIButton!
    @IBOutlet weak var transportation_btn: UIButton!
    @IBOutlet weak var shopping_and_gifts_btn: UIButton!
    @IBOutlet weak var supermarket_btn: UIButton!
    @IBOutlet weak var entertainment_btn: UIButton!
    
    
    @IBAction func supermarketPressed(sender: AnyObject) {
    sharedDBManager.addExpense( (newAmountTxt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
    newAmountTxt.text = ""
    sharedStatusModel.updateState()
    }
    
    @IBAction func healthAndBeautyPressed(sender: AnyObject) {
    sharedDBManager.addExpense( (newAmountTxt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
    newAmountTxt.text = ""
    sharedStatusModel.updateState()
    }
    
    @IBAction func rentAndBillsPressed(sender: AnyObject) {
    sharedDBManager.addExpense( (newAmountTxt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
    newAmountTxt.text = ""
    sharedStatusModel.updateState()
    }
    
    @IBAction func transportationPressed(sender: AnyObject) {
    sharedDBManager.addExpense( (newAmountTxt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
    newAmountTxt.text = ""
    sharedStatusModel.updateState()
    }
    
    @IBAction func shoppingAndGiftsPressed(sender: AnyObject) {
    sharedDBManager.addExpense( (newAmountTxt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
    newAmountTxt.text = ""
    sharedStatusModel.updateState()
    }
    
    @IBAction func entertainmentPressed(sender: AnyObject) {
    sharedDBManager.addExpense( (newAmountTxt.text! as NSString).doubleValue, InCategory: Category.Supermarket)
    newAmountTxt.text = ""
    sharedStatusModel.updateState()
    }
    
    override func viewDidLoad() {
        newAmountTxt.becomeFirstResponder()
    }

}