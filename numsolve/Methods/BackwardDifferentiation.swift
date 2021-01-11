//
//  BackwardDifferentiation.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/15/20.
//

import Foundation

class BackwardDifferentiation: NumericalMethod {
    
    typealias TableRow = (t: Float80, y: Float80, nexty: Float80)
    
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
        
        // calculate the first 3 rows using Runge-Kutta
        let rk = RungeKutta(diffeq: diffeq, y0: y0, stepSize: stepSize)
        rk.predict(n: 2)
        
        self.cache = rk.cache.map { (t: $0.t, y: $0.y, nexty: $0.yavg) }
    }
    
    // MARK: Functions
    
    @discardableResult func predict(n: Int) -> Float80 {
        if cache.indices.contains(n) {
            return cache[n].y
        }
    
        let startIndex = cache.count
        
        cache += [TableRow](repeating: (t: .nan, y: 0, nexty: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            cache[i].t = Float80(i) * stepSize
            cache[i].y = i == 0 ? y0 : cache[i - 1].nexty
            
            let solver = NumericalSolver( Equation {
                $0
            } right: { [self] (nextY) -> Float80 in
                let total = [
                    48  * cache[i].y,
                    -36 * cache[i - 1].y,
                    16  * cache[i - 2].y,
                    -3  * cache[i - 3].y,
                    12  * stepSize * diffeq.yPrime(cache[i].t + stepSize, nextY)
                ].reduce(0, +)
                return total / 25
            } )

            do {
                cache[i].nexty = try solver.solve(interval: (lower: -10, upper: 10))
            } catch {
                do {
                    cache[i].nexty = try solver.solve(interval: (lower: -100, upper: 100))
                } catch {
                    fatalError("Wrong bounds for back diff")
                }
                
            }
            
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                 |y                 |next y            ")
        print("----|------------------+------------------+------------------")
        
        for i in 0..<cache.count {
            print(String(format: "%04d|%.15f|%.15f|%.15f", i, Double(cache[i].t), Double(cache[i].y), Double(cache[i].nexty)))
        }
    }
    
}
