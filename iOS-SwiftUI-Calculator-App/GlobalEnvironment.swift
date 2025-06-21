//
//  GlobalEnvironment.swift
//  iOS-SwiftUI-Calculator-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

@Observable
class GlobalEnvironment {
    
    var display: String = "0"
    
    var shouldUseAC: Bool = true
    var highlightedArithmeticOperator: CalculatorButton? = nil
    
    var previousValue: Double? = nil
    var currentValue: Double = 0
    
    var currentOperator: CalculatorButton? = nil
    var enteringNewOperand = false
    
    func buttonTapped(button: CalculatorButton) {
        switch button {
        case .dot:
            display += button.title!
            currentValue = Double(display)!
            enteringNewOperand = true
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if enteringNewOperand {
                display += button.title!
                currentValue = Double(display)!
            } else {
                display = button.title!
                currentValue = button.value!
                enteringNewOperand = true
            }
            shouldUseAC = false
            highlightedArithmeticOperator = nil
        case .equals:
            if previousValue != nil {
                currentValue = calculateValue(operator_: currentOperator!, operand1: previousValue!, operand2: currentValue)
                displayCurrentValue()
                previousValue = nil
                currentOperator = nil
                enteringNewOperand = false
                shouldUseAC = false
            }
        case .plus, .minus, .multiply, .divide:
            if previousValue != nil {
                currentValue = calculateValue(operator_: currentOperator!, operand1: previousValue!, operand2: currentValue)
                displayCurrentValue()
            }
            previousValue = currentValue
            currentValue = 0
            currentOperator = button
            enteringNewOperand = false
            highlightedArithmeticOperator = button
        case .ac:
            if shouldUseAC {
                allClear()
            } else {
                clear()
            }
        case .plusMinus:
            currentValue = -currentValue
            displayCurrentValue()
            shouldUseAC = false
        case .percent:
            currentValue = 0.01 * currentValue
            displayCurrentValue()
            enteringNewOperand = false
            shouldUseAC = false
        }
    }
    
    func displayCurrentValue() {
        if floor(currentValue) == currentValue {
            display = String(Int(currentValue))
        } else {
            display = String(currentValue)
        }
    }
    
    func calculateValue(operator_: CalculatorButton, operand1: Double, operand2: Double) -> Double {
        switch operator_ {
        case .plus:
            return operand1 + operand2
        case .minus:
            return operand1 - operand2
        case .multiply:
            return operand1 * operand2
        case .divide:
            return operand1 / operand2
        default:
            return 0
        }
    }
    
    func allClear() {
        display = "0"
        currentValue = 0
        previousValue = nil
        currentOperator = nil
        enteringNewOperand = false
        shouldUseAC = true
        highlightedArithmeticOperator = nil
    }
    
    func clear() {
        currentValue = 0
        displayCurrentValue()
        enteringNewOperand = false
        shouldUseAC = true
    }
    
}
