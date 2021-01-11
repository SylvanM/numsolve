//
//  BackwardEuler.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/15/20.
//

import Foundation

class BackwardEuler: NumericalMethod {
    
    
    
    typealias TableRow = (t: Float80, y: Float80, nextY: Float80)
    
    // MARK: Properties
    
    var stepSize: Float80
    
    var diffeq: FirstOrderDE
    
    var cache: [TableRow] = []
    
    var y0: Float80
    
    // MARK: Initializers
    
    init(diffeq: FirstOrderDE, y0: Float80, stepSize: Float80 = 0.1) {
        self.diffeq = diffeq
        self.stepSize = stepSize
        self.y0 = y0
    }
    
    // MARK: Functions
    
    @discardableResult func predict(n: Int) -> Float80 {
        return predict(n: n, nextYFormula: nil)
    }
    
    @discardableResult func predict(n: Int, nextYFormula: ((_ t: Float80, _ y: Float80, _ stepSize: Float80) -> Float80)? = nil) -> Float80 {
        if cache.indices.contains(n) {
            return cache[n].y
        }
    
        let startIndex = cache.count
        
        cache += [TableRow](repeating: (t: .nan, y: 0, nextY: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            
            cache[i].t = Float80(i) * stepSize
            cache[i].y = i == 0 ? y0 : cache[i - 1].nextY
            
            if let nextY = nextYFormula {
                cache[i].nextY = nextY(cache[i].t, cache[i].y, stepSize)
            } else {
                let eq = Equation { (ynp1) -> Float80 in
                    ynp1
                } right: { [self] (ynp1) -> Float80 in
                    cache[i].y + stepSize * diffeq.yPrime(cache[i].t + stepSize, ynp1)
                }
                
                let solver = NumericalSolver(eq)
                
                do {
                    cache[i].nextY = try solver.solve()
                } catch {
                    fatalError("Could not solve the thing")
                }
            }
            
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                |y                |y_n+1            ")
        print("----+-----------------+-----------------+-----------------")
        
        for i in 0..<cache.count {
            print(String(format: "%04d|%.15f|%.15f|%.15f", i, Double(cache[i].t), Double(cache[i].y), Double(cache[i].nextY)))
        }
    }
    
}
