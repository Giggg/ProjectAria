//
//  ExpenseHistoryTableViewController.swift
//  Aria
//
//  Created by Guy Harpak on 4/24/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import UIKit

class ExpenseHistoryTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var expenseHistoryTable: UITableView!
    
    var expenseArray: [Double] = []
    
    let cellIdentifier = "expenseHistoryCell"



    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseHistoryTable.delegate = self
        expenseHistoryTable.dataSource = self
        expenseArray = sharedDBManager.getDoubleExpenseArray()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = String(format:"%.1f", expenseArray[row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(expenseArray[row])
    }
}
