//
//  GaugeViewViewController.swift
//  Aria
//
//  Created by Guy Harpak on 9/3/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import Foundation
import UIKit

class GaugeViewViewController : UIViewController {
    var gaugeShape : GaugeLayer?
    
    @IBOutlet weak var add_expense_btn: UIButton!
    @IBOutlet weak var amout_text_field: UITextField!

    @IBOutlet weak var expense_date_picker: UIDatePicker!
    @IBOutlet weak var state_date_picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gaugeShape = GaugeLayer ()
        self.view.layer.addSublayer(self.gaugeShape!)
        self.gaugeShape!.position = CGPointMake(self.view.bounds.size.width/2, state_date_picker.frame.origin.y-90)

        self.gaugeShape!.hidden = false
        var layer = CAShapeLayer()
        
        self.view.layer.insertSublayer(gaugeShape! , atIndex: 0)
        
    }
   
    func updateGauge () {
        let velocity = sharedStatusModel.getVelocity()
        gaugeShape?.updateGauge(velocity)
        
    }

    // FIXME- Changed action from rotate to updating the status to a different current date,
    // need to rename
    @IBAction func rotateBtnPressed(sender: AnyObject) {
        sharedStatusModel.updateState(state_date_picker.date)
        updateGauge()
//        gaugeShape?.rotateGauge((amout_text_field.text as NSString).doubleValue)
    }
    
    @IBAction func addBtnPressed(sender: AnyObject) {
        var date = expense_date_picker.date
        let expense = Expense(id: 1, amount: (amout_text_field.text! as NSString).doubleValue, InCategory: Category.Fuel, SetTimestamp: Expense.formatDate(date))
        sharedDBManager.addExpense(expense)
        sharedStatusModel.updateState(state_date_picker.date)
        updateGauge()
        
    }
    @IBAction func clearBtnPressed(sender: AnyObject) {
        sharedDBManager.clearDB()
        sharedStatusModel.updateState(state_date_picker.date)
        updateGauge()
    }
}