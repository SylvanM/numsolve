//
//  GeneralSolve.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/15/20.
//

import Foundation

class GeneralSolver {
    
    /// The equation to numerically solve
    var equation: FirstOrderDE
    
    /// The initial `y(0)`
    var y0: Float80
    
    // MARK: Initializers
    
    init(_ equation: FirstOrderDE, y0: Float80 = 0) {
        self.equation = equation
        self.y0       = y0
    }
    
    // MARK: Methods
    
    @discardableResult
    func euler(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = Euler(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func backwardEuler(n: Int, stepSize: Float80 = 0.1, nextYFormula: ((Float80, Float80, Float80) -> Float80)? = nil, verbose: Bool = true) -> Float80 {
        let solver = BackwardEuler(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n, nextYFormula: nextYFormula)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func improvedEuler(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = ImprovedEuler(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func rungeKutta(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = RungeKutta(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func adamsBashforth(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = AdamsBashforth(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func adamsMoulton(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = AdamsMoutlon(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func backDiff(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = BackwardDifferentiation(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
    @discardableResult
    func predictCorrect(n: Int, stepSize: Float80 = 0.1, verbose: Bool = true) -> Float80 {
        let solver = PredictorCorrector(diffeq: equation, y0: y0, stepSize: stepSize)
        let sol = solver.predict(n: n)
        if verbose { solver.showCacheTable() }
        return sol
    }
    
}
