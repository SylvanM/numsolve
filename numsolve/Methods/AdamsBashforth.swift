//
//  AdamsBashforth.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/13/20.
//

import Foundation

class AdamsBashforth: NumericalMethod {
    
    typealias TableRow = (t: Float80, y: Float80, f: Float80, nexty: Float80)
    
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
        
        self.cache = rk.cache.map { (t: $0.t, y: $0.y, f: $0.kn1, nexty: $0.yavg) }
    }
    
    // MARK: Functions
    
    @discardableResult func predict(n: Int) -> Float80 {
        if cache.indices.contains(n) {
            return cache[n].y
        }
    
        let startIndex = cache.count
        
        cache += [TableRow](repeating: (t: .nan, y: 0, f: 0, nexty: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            cache[i].t = Float80(i) * stepSize
            cache[i].y = i == 0 ? y0 : cache[i - 1].nexty
            cache[i].f = diffeq.yPrime(cache[i].t, cache[i].y)
            
            let total = [
                55  * cache[i - 0].f,
                -59 * cache[i - 1].f,
                37  * cache[i - 2].f,
                -9  * cache[i - 3].f
            ].reduce(0, +)
            
            cache[i].nexty = cache[i].y + (stepSize / 24) * total
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                 |y                 |next y            ")
        print("----|------------------+------------------+------------------")
        
        for i in 0..<cache.count {
            print(String(format: "%04d|%018f|%018f|%018f", i, cache[i].t, cache[i].y, cache[i].nexty))
        }
    }
    
}
