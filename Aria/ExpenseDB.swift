//
//  ExpenseDB.swift
//  Aria
//
//  Created by Guy Harpak on 4/18/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import Foundation

enum Category {case Supermarket, Pharm, Fuel}

class Expense :NSObject
{
    let id: (Int);
    let timestamp: (NSString);
    let amount: (Double);
    let category: Category

    init (id: Int, amount: Double, InCategory category:Category) {
        self.id = id;
        self.amount = amount;
        self.timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        self.category = category
    }
}


class ExpenseDBManager
{
    var expenseArray: [Expense] = [];
/*    var database: FMDatabase? = nil

    class var instance: ExpenseDB {
        sharedExpenseDB.database = FMDatabase(path: Util.getPath("expenseDB.db"))
        var path = Util.getPath("expenseDB.db")
        println("path : \(path)")
        return sharedExpenseDB
    }*/
    
    
    init () {
    }
    
    func getExpenseArray() -> [Expense] {
        return self.expenseArray
    }
    
    func getDoubleExpenseArray()-> [Double] {
        var expense_double_array : [Double] = []
        for expense in self.expenseArray {
            expense_double_array.append(expense.amount)
        }
        return expense_double_array
    }
    
    func addExpense (amount:Double, InCategory category:Category) {
        self.expenseArray.append(Expense(id: self.expenseArray.count, amount:amount, InCategory: category))
    }
}

let sharedDBManager = ExpenseDBManager()


