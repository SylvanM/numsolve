//
//  PartD.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/16/20.
//

import Foundation

class PartD {
    
    class func `do`() {
        
        print("Problem 1: y' = 3 + t - y")
        
        let solver = GeneralSolver(FirstOrderDE { 3 + $0 - $1 }, y0: 1)

        print("\na) Predictor-Corrector, h = 0.1")
        solver.predictCorrect(n: 5, stepSize: 0.1)

        print("\nb) Adams-Moulton, h = 0.1")
        solver.adamsMoulton(n: 5, stepSize: 0.1)
        
        print("\nc) Backward-Diff h = 0.1")
        solver.backDiff(n: 5, stepSize: 0.1)
        
        
        // 7
        
        solver.equation = FirstOrderDE { 0.5 - $0 + 2 * $1 }
        solver.y0       = 1

        print("\n\n7. y' = 0.5 - t + 2y")

        print("\na) Predictor-Corrector, h = 0.05")
        solver.predictCorrect(n: 40, stepSize: 0.05)

        print("\nb) Adams-Moulton, h = 0.05")
        solver.adamsMoulton(n: 40, stepSize: 0.05)
        
        print("\nc) Backward-Diff h = 0.05")
        solver.backDiff(n: 40, stepSize: 0.05)
    }
    
}
