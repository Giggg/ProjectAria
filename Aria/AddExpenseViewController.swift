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
    @IBOutlet weak var result_label: UILabel!
    @IBOutlet weak var velocity_result_label: UILabel!
    @IBOutlet weak var delete_btn: UIButton!
    
    @IBAction func enterPressed(sender: AnyObject) {
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
        updateResults()
    }
    
    
}
