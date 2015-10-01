//
//  AriaTests.swift
//  AriaTests
//
//  Created by Guy Harpak on 4/18/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import UIKit
import XCTest


class AriaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
/*        sharedDBManager.addExpense(Expense(id: 1, amount: 1.0, InCategory: .Fuel, SetTimestamp: "1984-05-30 12:04"))
        sharedDBManager.addExpense(Expense(id: 2, amount: 2.0, InCategory: .Fuel, SetTimestamp: "1984-03-02 12:04"))
        sharedDBManager.addExpense(Expense(id: 3, amount: 3.0, InCategory: .Fuel, SetTimestamp: "1984-06-02 12:04"))
        sharedDBManager.addExpense(Expense(id: 4, amount: 4.0, InCategory: .Fuel, SetTimestamp: "1984-06-03 12:04"))
        sharedDBManager.addExpense(Expense(id: 5, amount: 5.0, InCategory: .Fuel, SetTimestamp: "1984-06-30 12:04"))
        sharedDBManager.addExpense(Expense(id: 6, amount: 6.0, InCategory: .Fuel, SetTimestamp: "1984-06-01 12:04"))
        sharedDBManager.addExpense(Expense(id: 7, amount: 7.0, InCategory: .Fuel, SetTimestamp: "1984-07-02 12:04"))
        sharedDBManager.addExpense(Expense(id: 8, amount: 8.0, InCategory: .Fuel, SetTimestamp: "1984-07-01 12:04"))
        sharedDBManager.addExpense(Expense(id: 9, amount: 9.0, InCategory: .Fuel, SetTimestamp: "2015-09-07 12:04"))
        sharedDBManager.addExpense(Expense(id: 10, amount: 10.0, InCategory: .Fuel, SetTimestamp: "2015-09-05 12:04"))
        */
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sharedDBManager.clearDB()
    }
    
    func testSelectByMonth() {
        let formatter = NSDateFormatter ()
        formatter.dateFormat=Expense.DATE_FORMAT
        let test = formatter.stringFromDate(NSDate())
        let june = formatter.dateFromString("1984-06-01 12:04")
        let july = formatter.dateFromString("1984-07-20 12:04")
        let april = formatter.dateFromString("1984-04-01 12:04")
        
        var result = sharedDBManager.getByMonth(june!)
        XCTAssertFalse(result?.count==0, "June test has no results")
        XCTAssertTrue(result?.count==4, "June test didn't return enough results")
        for curr_expense in result! {
            XCTAssertTrue(curr_expense.amount >= 3.0 && curr_expense.amount <= 6.0, "June test returned \(curr_expense.timestamp)")
        }
        
        result = sharedDBManager.getByMonth(july!)
        XCTAssertFalse(result?.count==0, "July test has no results")
        XCTAssertTrue(result?.count==2, "June test didn't return enough results")
        for curr_expense in result! {
            XCTAssertTrue(curr_expense.amount >= 7.0 && curr_expense.amount <= 8.0, "June test returned \(curr_expense.timestamp)")
        }

        result = sharedDBManager.getByMonth(april!)
        XCTAssertTrue(result?.count==0, "April test returned results")

        
    }
    
    func testStatusByMonth() {
        XCTAssert(sharedStatusModel.getTotalExpense()==19.0, "StatusByMonth failed")
    }
    
}
