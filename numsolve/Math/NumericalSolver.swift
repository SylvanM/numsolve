//
//  NumericalSolver.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/14/20.
//

import Foundation

typealias Function = (Float80) -> Float80

/**
 * Represents an equation of the form
 * `l(t) = r(t)`
 */
struct Equation {
    
    // MARK: Properties
    
    /// The left side of the equation
    var left: Function
    
    /// The right side of the equation
    var right: Function
    
    // MARK: Initializers
    
    init(left: @escaping Function, right: @escaping Function) {
        self.left = left
        self.right = right
    }
    
    // MARK: Methods
    
    func difference(_ t: Float80) -> Float80 {
        left(t) - right(t)
    }
 
    
}

/**
 * Class meant for solving an equation numerically
 */
class NumericalSolver {
    
    // MARK: Properties
    
    /// The equation to solve
    let equation: Equation
    
    // MARK: Initializers
    
    init(_ equation: Equation) {
        self.equation = equation
    }
    
    // MARK: Methods
    
    // 0.0000000000000001
    
    // 8106589103223694151
    // 8106589103223693499
    
    /// This uses an iterative method to minimize the difference between the left and right sides of the equation
    func solve(maxIterations: Int = 1000, epsilon: Float80 = 0.00000000000000001, interval: (lower: Float80, upper: Float80) = (lower: -100, upper: 100)) throws -> Float80 {
        
        var (a, b) = interval
        
        if equation.difference(interval.lower) * equation.difference(interval.upper) >= 0 {
            throw SolveError.wrongInterval
        }
        
        var c = a
        
        while (b - a) >= epsilon {
            c = (a + b) / 2
            
            if equation.difference(c) == 0 {
                return c
            } else if (equation.difference(c) * equation.difference(a) < 0) {
                b = c
            } else {
                a = c
            }
                        
        }
        
        return c
        
    }
    
    // MARK: Enumerations
    
    /// An error thrown when solving the equation
    enum SolveError: Error {
        case wrongInterval
    }
    
}
