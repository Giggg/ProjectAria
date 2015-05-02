//
//  AddExpenseViewController.swift
//  Aria
//
//  Created by Guy Harpak on 4/22/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import Foundation
import UIKit

class AddExpenseViewController : UIViewController {
    
    @IBOutlet weak var amount_txt: UITextField!
    @IBOutlet weak var enter_btn: UIButton!
    
    
    @IBAction func enterPressed(sender: AnyObject) {
        sharedDBManager.addExpense( (amount_txt.text as NSString).doubleValue, InCategory: Category.Supermarket)
    }
    
    
}
