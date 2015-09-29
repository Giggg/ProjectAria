//: Playground - noun: a place where people can play

import UIKit
import Foundation



class CurrentStatusModel {

    var date = NSDate()
    var calendar: NSCalendar
    
    var day: Int = 0
    var endOfMonth: Int = 0
    
    var totalExpense:Double
    var velocity = 0.0
    var daysInMonth = 0
    var definedBudget: Double = 0
    // GGG Initialize, and Hedge
    

    init () {
        totalExpense = 0
        calendar = NSCalendar.currentCalendar()

        updateState()
    }
    
    func getVelocity () -> Double {
       
        if (Double(totalExpense) == 0) {
            return 0
        }
        let should = (Double(day) / Double(endOfMonth))
        let spent = (Double(totalExpense) / Double(definedBudget))
        velocity = spent / should
        return velocity

    }

  
    func updateState() {
        calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.NSDayCalendarUnit, .NSMonthCalendarUnit, .NSYearCalendarUnit], fromDate: date)
        let month: Int = components.month
        let year: Int = components.year
        day = components.day
        
        components.month  += 1
        components.day     = 0
        let lastDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        let componentsForLastDateOfMonth = calendar.components( .NSDayCalendarUnit , fromDate: lastDateOfMonth)
        endOfMonth = componentsForLastDateOfMonth.day
        
        
        var sum:Double = 0
        let expenseArray = sharedDBManager.getByMonth(date)
        
        if expenseArray != nil {
            for item in expenseArray! {
                sum = sum + item.amount
            }
        }
        
        totalExpense = sum
        daysInMonth = endOfMonth
        print(sum)
    }

    func getTotalExpense() -> Double {
        updateState()
        return totalExpense
    }
    
    func updateMonthlyBudget(newBudget: Double) {
        definedBudget = newBudget
    }
    
}

let sharedStatusModel = CurrentStatusModel()

/*
//QA
let Pharm = [1,2,3,4,5,5,4,3,2,1,7]
var result = CurrentStatusModel()
result.updateState(Pharm)
result.getVelocity()*/
