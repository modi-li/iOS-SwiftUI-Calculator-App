//
//  ContentView.swift
//  iOS-SwiftUI-Calculator-App
//
//  Created by Modi (Victor) Li
//

import SwiftUI

enum CalculatorButton {
    
    case dot, zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    
    var title: String? {
        switch self {
        case .dot: return "."
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ac: return "AC"
        default: return nil
        }
    }
    
    var imageSystemName: String? {
        switch self {
        case .equals: return "equal"
        case .plus: return "plus"
        case .minus: return "minus"
        case .multiply: return "multiply"
        case .divide: return "divide"
        case .plusMinus: return "plus.forwardslash.minus"
        case .percent: return "percent"
        default: return nil
        }
        
    }
    
    var value: Double? {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        default: return nil
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .dot, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Colors.tint1
        case .equals:
            return Colors.tint2
        case .plus, .minus, .multiply, .divide:
            return Colors.tint3
        case .ac, .plusMinus, .percent:
            return Colors.tint4
        }
    }
    
    var font: Font {
        switch self {
        case .dot, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return .system(size: 36, weight: .medium)
        case .equals, .plus, .minus, .multiply, .divide, .plusMinus:
            return .system(size: 34, weight: .medium)
        case .ac:
            return .system(size: 32, weight: .medium)
        case .percent:
            return .system(size: 28, weight: .medium)
        }
    }
    
}


class GlobalEnvironment: ObservableObject {
    
    @Published var display: String = "0"
    
    @Published var shouldUseAC: Bool = true
    @Published var highlightedArithmeticOperator: CalculatorButton? = nil
    
    var previousValue: Double? = nil
    var currentValue: Double = 0
    var currentOperator: CalculatorButton? = nil
    var enteringNewOperand = false
    
    func buttonTapped(button: CalculatorButton) {
        switch button {
        case .dot, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if enteringNewOperand {
                display += button.title!
                currentValue = Double(display)!
            } else if button == .dot {
                display += button.title!
                currentValue = Double(display)!
                enteringNewOperand = true
            } else {
                display = button.title!
                currentValue = button.value!
                enteringNewOperand = true
            }
            shouldUseAC = false
            highlightedArithmeticOperator = nil
        case .equals:
            if previousValue != nil {
                let newValue = calculateValue(operator_: currentOperator!, operand1: previousValue!, operand2: currentValue)
                display = getDisplayFromValue(newValue)
                previousValue = nil
                currentValue = newValue
                currentOperator = nil
                enteringNewOperand = false
                shouldUseAC = false
            }
        case .plus, .minus, .multiply, .divide:
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
            display = getDisplayFromValue(currentValue)
            shouldUseAC = false
        case .percent:
            currentValue = 0.01 * currentValue
            display = getDisplayFromValue(currentValue)
            enteringNewOperand = false
            shouldUseAC = false
        }
    }
    
    func getDisplayFromValue(_ value: Double) -> String {
        if floor(value) == value {
            return String(Int(value))
        } else {
            return String(value)
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
        display = getDisplayFromValue(currentValue)
        enteringNewOperand = false
        shouldUseAC = true
    }
    
}


struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display)
                        .lineLimit(1)
                        .font(.system(size: 70))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.trailing, 20)
                }
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }
        }
    }
    
}


struct CalculatorButtonView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var button: CalculatorButton
    
    let buttonsWithBiggerFont: [CalculatorButton] = [.equals, .plus, .minus, .multiply, .divide]
    
    var body: some View {
        Button {
            env.buttonTapped(button: button)
        } label: {
            if button.title == nil {
                Image(systemName: button.imageSystemName!)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundStyle(buttonForegroundColor)
                    .background(buttonBackgroundColor)
                    .clipShape(Capsule())
                    .font(button.font)
            } else {
                Text(buttonTitle)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundStyle(buttonForegroundColor)
                    .background(buttonBackgroundColor)
                    .clipShape(Capsule())
                    .font(button.font)
            }
        }
    }
    
    var buttonTitle: String {
        if button == .ac {
            return env.shouldUseAC ? "AC" : "C"
        } else {
            return button.title!
        }
    }
    
    var buttonWidth: CGFloat {
        if button == .zero {
            return ((UIScreen.current.bounds.width) - 12 * 4 ) / 4 * 2
        } else {
            return ((UIScreen.current.bounds.width) - 12 * 5 ) / 4
        }
    }
    
    var buttonHeight: CGFloat {
        return ((UIScreen.current.bounds.width) - 12 * 5 ) / 4
    }
    
    var buttonForegroundColor: Color {
        if button == env.highlightedArithmeticOperator {
            return Colors.tint2
        } else {
            return .white
        }
    }
    
    var buttonBackgroundColor: Color {
        if button == env.highlightedArithmeticOperator {
            return .white
        } else {
            return button.backgroundColor
        }
    }
    
}


#Preview {
    ContentView()
        .environmentObject(GlobalEnvironment())
}
