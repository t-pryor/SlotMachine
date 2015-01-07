//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Tim Pryor on 2015-01-04.
//  Copyright (c) 2015 Tim Pryor. All rights reserved.
//

import Foundation

class SlotBrain {
  
//  class func unpackSlotsIntoSlotRows(slots: [[Slot]]) -> [[Slot]] {
//    var slotRow:  [Slot] = []
//    var slotRow2: [Slot] = []
//    var slotRow3: [Slot] = []
//    
//    for slotArray in slots {
//      for var index = 0; index < slotArray.count; index++ {
//        let slot = slotArray[index]
//        if index == 0 {
//          slotRow.append(slot)
//        } else if index == 1 {
//          slotRow2.append(slot)
//        } else if index == 2 {
//          slotRow3.append(slot)
//        } else {
//          println("Error")
//        }
//      }
//    }
//    var slotsInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]
//    return slotsInRows
//  }
  
  class func unpackSlotsIntoSlotRows(slotsInCols: [[Slot]]) -> [[Slot]] {
    //because slotsInRows and slotsInCols are structs (arrays), creates a copy by value, so we can do this
    var slotsInRows = slotsInCols //pre-initialize with right capacity
    
    for i in 0...slotsInCols.count - 1 {
      for j in 0...slotsInCols.count - 1 {
        slotsInRows[i][j] = slotsInCols[j][i]
      }
    }
    return slotsInRows
  }


  class func computeWinnings(slots: [[Slot]]) -> Int {
    
    var slotsInRows = unpackSlotsIntoSlotRows(slots)
    var winnings = 0
    
    var flushWinCount = 0
    var threeOfAKindWinCount = 0
    var straightWinCount = 0
    
    for slotRow in slotsInRows {
      
      if checkFlush(slotRow) == true {
        println("flush")
        winnings += 1
        flushWinCount += 1
      }
      
      if checkThreeInARow(slotRow) == true {
        println("three in a row")
        winnings += 1
        straightWinCount += 1
      }
      
      if checkThreeOfAKind(slotRow) == true {
        println("Three of a Kind")
        winnings += 3
        threeOfAKindWinCount += 1
      }
      
    }
    
    if flushWinCount == slotsInRows.count {
      println("Royal Flush")
      winnings += 15
    }
    
    if straightWinCount == 3 {
      println("Epic Straight")
      winnings += 1000
    }
    
    if threeOfAKindWinCount == 3 {
      println("Threes all around")
      winnings += 50
    }
    
    return winnings
    
  }
  
  
  class func checkFlush(slotRow: [Slot]) -> Bool {
    
    var redCount = 0
    var blackCount = 0
    
    //check for emptyArray
    if slotRow.isEmpty {
      println("Empty array passed in")
      return false
    }
    
    for elem in slotRow {
      if elem.isRed {
        redCount++
      } else {
        blackCount++
      }
    }
    
    if redCount == slotRow.count || blackCount == slotRow.count {
      return true
    } else {
      return false
    }
    
//    let slot1 = slotRow[0]
//    let slot2 = slotRow[1]
//    let slot3 = slotRow[2]
//    
//    //redo this with for loop
//    
//    if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
//      return true
//    } else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
//      return true
//    } else {
//      return false
//    }
  
  
    
  }
  
  class func checkThreeInARow(slotRow: [Slot]) -> Bool {
    
    let slot1 = slotRow[0]
    let slot2 = slotRow[1]
    let slot3 = slotRow[2]
    
    if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
      return true
    } else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
      return true
    } else {
      return false
    }
    
  }

  class func checkInARow(slotRow: [Slot]) -> Bool {
    var values = slotRow.map() { $0.value }
    
    if values[0] < values[1] { //ascending
      for (i, value) in enumerate(values) {
        if (i > 0 && value != values[i - 1] + 1) {
          return false
        }
      }
      return true //slot row has three in a row-ascending
    }
    else if values[0] > values[1] { //descending
      for (i, value) in enumerate(values) {
        if (i > 0 && value != values[i - 1] - 1) {
          return false
        }
      }
      return true //slotRow has thre in a row-descending
      }
    else { //first two array elements are equal
      return false
    }
  }
  
  class func checkThreeOfAKind(slotRow: [Slot]) -> Bool {
    let slot1 = slotRow[0]
    let slot2 = slotRow[1]
    let slot3 = slotRow[2]
    
    if slot1.value == slot2.value && slot1.value == slot3.value {
      return true
    } else {
      return false
    }
  }
  
}

