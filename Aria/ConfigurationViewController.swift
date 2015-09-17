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
    }
   
    
    @IBAction func extraIncomePressed(sender: AnyObject) {
        
        print(sharedStatusModel.definedBudget)

    }
    
    
}