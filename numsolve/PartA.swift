//
//  PartA.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/15/20.
//

import Foundation

class PartA {

    class func `do`() {
        
        print("Problem 1: y' = 3 + t - y")

        print("\na) Euler, h = 0.05")
        let solver = GeneralSolver(FirstOrderDE { 3 + $0 - $1 }, y0: 1)
        solver.euler(n: 8, stepSize: 0.05)

        print("\nb) Euler, h = 0.025")
        solver.euler(n: 16, stepSize: 0.025)

        // problem 2

        solver.equation = FirstOrderDE { 5 * $0 - 3 * sqrt($1) }
        solver.y0       = 2

        print("\n\n2. y' = 5t - 3√y")

        print("\na) Euler, h = 0.05")
        solver.euler(n: 8, stepSize: 0.05)


        print("\nb) Euler, h = 0.025")
        solver.euler(n: 16, stepSize: 0.025)

        print("\nc) Backward Euler, h = 0.05")
        solver.backwardEuler(n: 8, stepSize: 0.05)

        print("\nd) Backward Euler, h = 0.025")
        solver.backwardEuler(n: 16, stepSize: 0.025)

        // problem 5

        solver.equation = FirstOrderDE { (powl($1, 2) + 2 * $0 * $1) / (3 + powl($0, 2)) }
        solver.y0       = 0.5

        print("\n\n5. y' = (y^2 + 2ty) / (3 + t^2)")

        print("\na) Euler, h = 0.05")
        solver.euler(n: 8, stepSize: 0.05)


        print("\nb) Euler, h = 0.025")
        solver.euler(n: 16, stepSize: 0.025)

        // problem 7

        solver.equation = FirstOrderDE { 0.5 - $0 + 2 * $1 }
        solver.y0       = 1

        print("\n\n7. y' = 0.5 - t + 2y")

        print("\na) Euler, h = 0.025")
        solver.euler(n: 80, stepSize: 0.025)

        print("\nb) Euler, h = 0.0125")
        solver.euler(n: 160, stepSize: 0.0125)

        print("\nc) Backward Euler, h = 0.025")
        solver.backwardEuler(n: 80, stepSize: 0.025) { (t, y, h) -> Float80 in
            let numerator = y + 0.5 * h - t * h - pow(h, 2)
            let denominator = 1 - 2 * h
            return numerator / denominator
        }

        print("\nd) Backward Euler, h = 0.0125")
        solver.backwardEuler(n: 160, stepSize: 0.0125)

        // problem 9

        solver.equation = FirstOrderDE { sqrt( $0 + $1 ) }
        solver.y0       = 3

        print("\n\nProblem 9: y' = √(t + y), y(0) = 3")

        print("\na) Euler, h = 0.025")
        solver.euler(n: 80, stepSize: 0.025)

        print("\nb) Euler, h = 0.0125")
        solver.euler(n: 160, stepSize: 0.0125)

        print("\nc) Backward Euler, h = 0.025")
        solver.backwardEuler(n: 80, stepSize: 0.025)

        print("\nd) Backward Euler, h = 0.0125")
        solver.backwardEuler(n: 160, stepSize: 0.0125)

        // problem 11

        solver.equation = FirstOrderDE { (4 - $0 * $1) / (1 + pow($1, 2)) }
        solver.y0       = -2

        print("\n\nProblem 11: y' = (4 - ty) / (1 + y^2), y(0) = 3")

        print("\na) Euler, h = 0.025")
        solver.euler(n: 80, stepSize: 0.025)

        print("\nb) Euler, h = 0.0125")
        solver.euler(n: 160, stepSize: 0.0125)

        print("\nc) Backward Euler, h = 0.025")
        solver.backwardEuler(n: 80, stepSize: 0.025)

        print("\nd) Backward Euler, h = 0.0125")
        solver.backwardEuler(n: 160, stepSize: 0.0125)

    }
    
}
