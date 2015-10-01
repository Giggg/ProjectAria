//
//  HistoryViewController.swift
//  Aria
//
//  Created by Guy Harpak on 9/30/15.
//  Copyright © 2015 OnBudget. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UITableViewController {
   @IBOutlet var expenseHistoryTable: UITableView!
    
    var expense_array: [Expense] = []
    
    let cellIdentifier = "HistoryTableCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseHistoryTable.delegate = self
        expenseHistoryTable.dataSource = self
        expense_array = sharedDBManager.getExpenseArray()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expense_array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> HistoryTableCell {
        let cell  = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HistoryTableCell
        
        let row = indexPath.row
        cell.expense_Label.text = String(format:"%.1f", expense_array[row].amount)
        let timestamp_nsdate = NSDate (timeIntervalSince1970: expense_array[row].timestamp_unix)
        let date_formatter = NSDateFormatter()
        date_formatter.dateStyle = NSDateFormatterStyle.LongStyle
        date_formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        print (date_formatter.stringFromDate(timestamp_nsdate))
        print (date_formatter.stringFromDate(NSDate()))
        cell.date_Label.text =  date_formatter.stringFromDate(timestamp_nsdate)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(expense_array[row])
    }

}
