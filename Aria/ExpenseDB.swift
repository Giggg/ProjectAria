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
    
    func getTimestamp() -> NSString {
        return timestamp
    }
}


class ExpenseDBManager
{
    var database_path: String;
    var expenseArray: [Expense] = [];
/*    var database: FMDatabase? = nil

    class var instance: ExpenseDB {
        sharedExpenseDB.database = FMDatabase(path: Util.getPath("expenseDB.db"))
        var path = Util.getPath("expenseDB.db")
        println("path : \(path)")
        return sharedExpenseDB
    }*/
    
    
    init () {
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        
        database_path = docsDir.stringByAppendingPathComponent("expenseDB.db")
        
        if !filemgr.fileExistsAtPath(database_path as String) {
            
            let database_ref = FMDatabase(path: database_path as String)
            if database_ref == nil {
                println("Error: \(database_ref.lastErrorMessage())")
            }
            if database_ref.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS EXPENSES (ID INTEGER PRIMARY KEY AUTOINCREMENT, AMOUNT REAL, CATEGORY TEXT, DATE TEXT)"
                if !database_ref.executeStatements(sql_stmt) {
                    println("Error: \(database_ref.lastErrorMessage())")
                }
                database_ref.close()
            } else {
                println("Error: \(database_ref.lastErrorMessage())")
            }
        }
    }
    
    func getExpenseArray() -> [Expense] {
        return self.expenseArray
    }
    
    func getDoubleExpenseArray()-> [Double] {
        var expense_double_array : [Double] = []
        let database_ref = FMDatabase(path: database_path as String)
        
        if database_ref.open() {
            let querySQL = "SELECT amount FROM EXPENSES"
            
            let results:FMResultSet? = database_ref.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            while results?.next() == true {
                expense_double_array.append(results!.doubleForColumn("amount"))
            }
            database_ref.close()
        } else {
            println("Error: \(database_ref.lastErrorMessage())")
        }
        return expense_double_array
    }
    
    func addExpense (amount:Double, InCategory category:Category) {
        let added_expense = Expense(id: self.expenseArray.count, amount:amount, InCategory: category)
        self.expenseArray.append(added_expense)
        let database_ref = FMDatabase(path: database_path as String)
        
        if database_ref.open() {
            // TODO: get category from parameter & get date
            let insertSQL = "INSERT INTO EXPENSES (amount, category, date) VALUES ('\(amount)', 'Fuel', '\(added_expense.getTimestamp())')"
            
            let result = database_ref.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println ( "Failed to add expense to DB")
                println("Error: \(database_ref.lastErrorMessage())")
            } else {
                println ("Expense Added")
            }
        } else {
            println("Error: \(database_ref.lastErrorMessage())")
        }
    }
    
    
}

let sharedDBManager = ExpenseDBManager()


