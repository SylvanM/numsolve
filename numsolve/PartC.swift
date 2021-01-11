//
//  PartC.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/16/20.
//

import Foundation

class PartC {
    
    class func `do`() {
        
        print("Problem 1: y' = 3 + t - y")

        print("\na) Runge-Kutta, h = 0.1")
        let solver = GeneralSolver(FirstOrderDE { 3 + $0 - $1 }, y0: 1)
        solver.rungeKutta(n: 8, stepSize: 0.1)

        print("\nb) Runge-Kutta, h = 0.05")
        solver.rungeKutta(n: 16, stepSize: 0.05)
        
        
        
        
        print("\n\nProblem 2: y' = 5t - 3√y, y(0) = 2")
        
        solver.equation = FirstOrderDE(yPrime: { (t, y) -> Float80 in
            5 * t - 3 * sqrt(y)
        })
        solver.y0 = 2

        print("\na) Runge-Kutta, h = 0.1")
        solver.rungeKutta(n: 8, stepSize: 0.1)

        print("\nb) Runge-Kutta, h = 0.05")
        solver.rungeKutta(n: 16, stepSize: 0.05)
        
        
        
        print("\n\nProblem 5: y' = (y^2 + 2ty) / (3 + t^2), y(0) = 0.5")
        
        solver.equation = FirstOrderDE(yPrime: { (t, y) -> Float80 in
            let numerator = pow(y, 2) + 2 * t * y
            let denominator = 3 + pow(t, 2)
            return numerator / denominator
        })
        solver.y0 = 0.5

        print("\na) Runge-Kutta, h = 0.1")
        solver.rungeKutta(n: 8, stepSize: 0.1)

        print("\nb) Runge-Kutta, h = 0.05")
        solver.rungeKutta(n: 16, stepSize: 0.05)
        
        // 7
        
        solver.equation = FirstOrderDE { 0.5 - $0 + 2 * $1 }
        solver.y0       = 1

        print("\n\n7. y' = 0.5 - t + 2y")

        print("\na) Runge-Kutta, h = 0.1")
        solver.rungeKutta(n: 20, stepSize: 0.1)

        print("\nb) Runge-Kutta, h = 0.05")
        solver.rungeKutta(n: 40, stepSize: 0.05)

        // problem 9

        solver.equation = FirstOrderDE { sqrt( $0 + $1 ) }
        solver.y0       = 3

        print("\n\nProblem 9: y' = √(t + y), y(0) = 3")

        print("\na) Runge-Kutta, h = 0.1")
        solver.rungeKutta(n: 20, stepSize: 0.1)

        print("\nb) Runge-Kutta, h = 0.05")
        solver.rungeKutta(n: 40, stepSize: 0.05)

        // problem 11

        solver.equation = FirstOrderDE { (4 - $0 * $1) / (1 + pow($1, 2)) }
        solver.y0       = -2

        print("\n\nProblem 11: y' = (4 - ty) / (1 + y^2), y(0) = -2")

        print("\na) Runge-Kutta, h = 0.1")
        solver.rungeKutta(n: 20, stepSize: 0.1)

        print("\nb) Runge-Kutta, h = 0.05")
        solver.rungeKutta(n: 40, stepSize: 0.05)
        
    }
    
}
