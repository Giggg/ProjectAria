//
//  ConfigurationViewController.swift
//  Aria
//
//  Created by Nir Horesh on 17/09/2015.
//  Copyright © 2015 OnBudget. All rights reserved.
//

import Foundation
import UIKit

class ConfigurationViewController: UIViewController {
    
    @IBOutlet weak var monthly_budget_txt: UITextField!
    @IBOutlet weak var extra_income: UITextField!
    
    @IBAction func monthlyBudgetUpdatePressed(sender: AnyObject) {
        sharedStatusModel.updateMonthlyBudget((monthly_budget_txt.text! as NSString).doubleValue)
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to update monthly budget?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Approve", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
   
    
    @IBAction func extraIncomePressed(sender: AnyObject) {
        
        print(sharedStatusModel.definedBudget)

    }

}