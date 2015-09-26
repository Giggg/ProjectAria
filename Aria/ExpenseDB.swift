//
//  ExpenseDB.swift
//  Aria
//
//  Created by Guy Harpak on 4/18/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

//TODO consider changing class design, so as to accomodate a model design pattern

import Foundation

enum Category : String {case Supermarket = "Supermarket", Pharm = "Pharm", Fuel = "Fuel"}


struct Expense
{
    let id: (Int);
    var timestamp: (NSString);
    let amount: (Double);
    let category: Category
    static let DATE_FORMAT :(String) = "yyyy-MM-dd HH:mm" // change this string to determine the date format
    
    
    private func getTimeStamp (date: NSDate)-> NSString {
        let date_formatter = NSDateFormatter()
        date_formatter.setLocalizedDateFormatFromTemplate(Expense.DATE_FORMAT)
        return date_formatter.stringFromDate(date)
    }
    
    /* This function returns the date in a string formatted according to DB convention */
    static func formatDate (date: NSDate)->NSString {
        var result = ""
        let date_formatter = NSDateFormatter()
        result = ""
        date_formatter.setLocalizedDateFormatFromTemplate("yyyy" )
        result = result.stringByAppendingString(date_formatter.stringFromDate(NSDate()))
        result = result.stringByAppendingString("-")
        date_formatter.setLocalizedDateFormatFromTemplate("MM" )
        result = result.stringByAppendingString(date_formatter.stringFromDate(NSDate()))
        result = result.stringByAppendingString("-")
        date_formatter.setLocalizedDateFormatFromTemplate("dd" )
        result = result.stringByAppendingString(date_formatter.stringFromDate(NSDate()))
        result = result.stringByAppendingString(" ")
        date_formatter.setLocalizedDateFormatFromTemplate("HH" )
        result = result.stringByAppendingString(date_formatter.stringFromDate(NSDate()))
        result = result.stringByAppendingString(" ")
        result = result.stringByAppendingString(":")
        date_formatter.setLocalizedDateFormatFromTemplate("MM" )
        result = result.stringByAppendingString(date_formatter.stringFromDate(NSDate()))
        
        return result
    }
    
    /* this init function adds the current time as timestamp */
    // TODO change to unlocalized dates? for off shore purchases...
    init (id: Int, amount: Double, InCategory category:Category) {
        self.id = id; // todo: handle id synchronization with database
        self.amount = amount;
        let date_formatter = NSDateFormatter()
        self.timestamp = Expense.formatDate(NSDate())
        print("Stamp: \(self.timestamp)")
        self.category = category
    }
    
    /* this init function gets the timestamp as a string from the caller */
    init (id: Int, amount: Double, InCategory category:Category, SetTimestamp timestamp: NSString) {
        self.id = id; // todo: handle id synchronization with database
        self.amount = amount;
        self.timestamp = timestamp
        self.category = category
    }


    func getTimestamp() -> NSString {
        return timestamp
    }
}


class ExpenseDBManager
{
    var database_path: NSURL;
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
        let dirPaths:NSURL?
        // TODO change directort to support files directory- no reason for the user to access the DB
//        do {
            dirPaths = try? filemgr.URLForDirectory(.ApplicationSupportDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
/*        } catch {
            print ("Error getting file directory")
            return
        }*/
        assert(dirPaths != nil)
        database_path = dirPaths!.URLByAppendingPathComponent("expenseDB.db")
        print("Database path: %s", database_path.absoluteString, terminator: "")
        let database_ref = FMDatabase(path: database_path.absoluteString)
        if database_ref == nil {
            print("Error: \(database_ref.lastErrorMessage())")
        }
        if database_ref.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS EXPENSES (ID INTEGER PRIMARY KEY AUTOINCREMENT, AMOUNT REAL, CATEGORY TEXT, DATE TEXT)"
            if !database_ref.executeStatements(sql_stmt) {
                print("Error: \(database_ref.lastErrorMessage())")
            }
            database_ref.close()
        }
            
        else {
            print("Error: \(database_ref.lastErrorMessage())")
        }
    }
    
    func getExpenseArray() -> [Expense] {
        return self.expenseArray
    }

    
    func clearDB() {
        let database_ref = FMDatabase(path: database_path.absoluteString)
        
        if database_ref.open() {
            let sql_stmt = "DELETE from EXPENSES"
            if !database_ref.executeUpdate(sql_stmt, withArgumentsInArray: [1]) {
                print("Error: \(database_ref.lastErrorMessage())")
            }
            database_ref.close()
        } else {
            print("Error: \(database_ref.lastErrorMessage())")
        }
    }

    func parseExpenseByID (id: Int) -> Expense? {
        var result: Expense
        let database_ref = FMDatabase(path: database_path.absoluteString)

        
        if database_ref.open() {
            let querySQL = "SELECT * FROM EXPENSES where id=\(id)"
            let results:FMResultSet? = database_ref.executeQuery(querySQL,
                withArgumentsInArray: nil)
            if (results == nil) {
                return nil
            }
            if results!.next() {
                let category  = Category(rawValue: results!.stringForColumn("Category"))
                let id = results!.intForColumn("id")
                let amount_result = results!.doubleForColumn("amount")
                let timestamp = results!.stringForColumn("date")
                result = Expense (id: Int(id), amount: amount_result, InCategory: category!, SetTimestamp: timestamp)
            }
            else {
                return nil
            }

            database_ref.close()
        } else {
            print("Error: \(database_ref.lastErrorMessage())")
            return nil
        }
        return result
    }
    
    func getByMonth (date: NSDate) -> [Expense]? {
        var result: [Expense] = []
        let database_ref = FMDatabase(path: database_path.absoluteString)
        let date_formatter = NSDateFormatter()
        date_formatter.dateFormat = Expense.DATE_FORMAT
        let calendar = NSCalendar.currentCalendar()

        let first_day_comp = calendar.components([.Year, .Month, .Day], fromDate: date)
        first_day_comp.setValue(1, forComponent: .Day)
        let first_day = date_formatter.stringFromDate(calendar.dateFromComponents(first_day_comp)!)
        
        var last_day_date = calendar.dateByAddingUnit(.Month, value: 1, toDate: date, options:[])
        last_day_date = calendar.dateByAddingUnit(.Day, value: -1, toDate: last_day_date!, options: [])
        //let last_day_comp = calendar.components(.CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitYear, fromDate: last_day_date!)
        let last_day = date_formatter.stringFromDate(last_day_date!)
        

        if database_ref.open() {
            let querySQL = "SELECT * FROM EXPENSES where date BETWEEN '\(first_day)' AND '\(last_day)'"
            let results:FMResultSet? = database_ref.executeQuery(querySQL,
                withArgumentsInArray: nil)
            /*if (results?.hasAnotherRow() == nil) {
                return nil
            }*/ // TODO: uncomment- i did it for using XCTest on the function
            while results!.next() {
                let category  = Category(rawValue: results!.stringForColumn("Category"))
                let id = results!.intForColumn("id")
                let amount_result = results!.doubleForColumn("amount")
                let timestamp = results!.stringForColumn("date")
                result.append(Expense (id: Int(id), amount: amount_result, InCategory: category!, SetTimestamp: timestamp))
            }
            database_ref.close()
        } else {
            print("Error: \(database_ref.lastErrorMessage())")
        }
        return result
    }
    
    
    func getDoubleExpenseArray()-> [Double] {
        var expense_double_array : [Double] = []
        let database_ref = FMDatabase(path: database_path.absoluteString)
        
        if database_ref.open() {
            let querySQL = "SELECT amount FROM EXPENSES"
            
            let results:FMResultSet? = database_ref.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            while results?.next() == true {
                expense_double_array.append(results!.doubleForColumn("amount"))
            }
            database_ref.close()
        } else {
            print("Error: \(database_ref.lastErrorMessage())")
        }
        return expense_double_array
    }

    /* add expense using expense object */
    func addExpense (expense_to_add: Expense) {
        self.expenseArray.append(expense_to_add)
        let database_ref = FMDatabase(path: database_path.absoluteString)
        
        if database_ref.open() {
            // TODO: get category from parameter & get date
            let insertSQL = "INSERT INTO EXPENSES (amount, category, date) VALUES ('\(expense_to_add.amount)', 'Fuel', '\(expense_to_add.timestamp)')"
            
            let result = database_ref.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                print ( "Failed to add expense to DB")
                print("Error: \(database_ref.lastErrorMessage())")
            } else {
                print ("Expense Added")
            }
        } else {
            print("Error: \(database_ref.lastErrorMessage())")
        }
    }

   
    /* add expense using expense details */
    func addExpense (amount:Double, InCategory category:Category) {
        let added_expense = Expense(id: self.expenseArray.count, amount:amount, InCategory: category)
        self.expenseArray.append(added_expense)
        let database_ref = FMDatabase(path: database_path.absoluteString)
        
        if database_ref.open() {
            // TODO: get category from parameter & get date
            let insertSQL = "INSERT INTO EXPENSES (amount, category, date) VALUES ('\(amount)', 'Fuel', '\(added_expense.getTimestamp())')"
            
            let result = database_ref.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                print ( "Failed to add expense to DB")
                print("Error: \(database_ref.lastErrorMessage())")
            } else {
                print ("Expense Added")
            }
        } else {
            print("Error: \(database_ref.lastErrorMessage())")
        }
    }
    
    
}

let sharedDBManager = ExpenseDBManager()


