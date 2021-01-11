//
//  PartE.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/16/20.
//

import Foundation

class PartE {
    
    typealias TableRow = (t: Float80, actual: Float80, eulerError: Float80, backEulerError: Float80, impEulerError: Float80, rkError: Float80, predCorrError: Float80, bashforthError: Float80, moultonError: Float80, backDiffError: Float80)
    
    static var table: [TableRow] = []
    
    class private func actual(_ t: Float80) -> Float80 {
        2 + t - exp(t)
    }
    
    class func `do`() {
        
        print("y' = 3 + t - y, y(0) = 1")
        print("y = 2 + t - e^t\n")
        
        let solver = GeneralSolver(FirstOrderDE(yPrime: { (t, y) -> Float80 in
            3 + t - y
        }))
        
        solver.y0 = 1
        
        // up to t = 0.5
        // h = 0.1, 0.0125
        for h in [Float80(0.1), 0.05, 0.025, 0.0125] {
            let n = Int(0.5 / h)
            table = [TableRow](repeating: TableRow(t: 0, actual: 0, eulerError: 0, backEulerError: 0, impEulerError: 0, rkError: 0, predCorrError: 0, bashforthError: 0, moultonError: 0, backDiffError: 0), count: n + 1)
            
        
            
            for i in 0...n {
                table[i].t = h * Float80(i)
                table[i].actual         = actual(table[i].t)
                table[i].eulerError     = solver.euler(n: i,            stepSize: h, verbose: false)    - table[i].actual
                table[i].backEulerError = solver.backwardEuler(n: i,    stepSize: h, verbose: false)    - table[i].actual
                table[i].impEulerError  = solver.improvedEuler(n: i,    stepSize: h, verbose: false)    - table[i].actual
                table[i].rkError        = solver.rungeKutta(n: i,       stepSize: h, verbose: false)    - table[i].actual
                table[i].predCorrError  = solver.predictCorrect(n: i,   stepSize: h, verbose: false)    - table[i].actual
                table[i].bashforthError = solver.adamsBashforth(n: i,   stepSize: h, verbose: false)    - table[i].actual
                table[i].moultonError   = solver.adamsMoulton(n: i,     stepSize: h, verbose: false)    - table[i].actual
                table[i].backDiffError  = solver.backDiff(n: i,         stepSize: h, verbose: false)    - table[i].actual
            }
            
            print("Error Analysis, h = \(h)")
            print("n   |t                |y-Actual         |euler-error      |b-euler error    |imp-euler error  |RK Error         |Pred-Corr Error  |Bashforth Error  |Moulton Error    |Back-Diff Error  ")
            print("----|-----------------+-----------------+-----------------+-----------------+-----------------+-----------------+-----------------+-----------------+-----------------+-----------------")
        
            for i in 0..<table.count {
                print(String(format: "%04d|%.15f|%.15f|%.15f|%.15f|%.15f|%.15f|%.15f|%.15f|%.15f|%.15f", i, Double(table[i].t), Double(table[i].actual), Double(table[i].eulerError), Double(table[i].backEulerError), Double(table[i].impEulerError), Double(table[i].rkError), Double(table[i].predCorrError), Double(table[i].bashforthError), Double(table[i].moultonError), Double(table[i].backDiffError)))
            }
            
            print("\n\n")
        }
        
    }
    
}
