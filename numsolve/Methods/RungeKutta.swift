//
//  RungeKutta.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/13/20.
//

import Foundation

class RungeKutta: NumericalMethod {
    
    typealias TableRow = (t: Float80, y: Float80, kn1: Float80, kn2: Float80, kn3: Float80, kn4: Float80, yavg: Float80)
    
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
        if cache.indices.contains(n) {
            return cache[n].y
        }
    
        let startIndex = cache.count
        
        cache += [TableRow](repeating: (t: .nan, y: 0, kn1: 0, kn2: 0, kn3: 0, kn4: 0, yavg: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            cache[i].t      = Float80(i) * stepSize
            cache[i].y      = i == 0 ? y0 : cache[i - 1].yavg
            cache[i].kn1    = diffeq.yPrime(cache[i].t, cache[i].y)
            cache[i].kn2    = diffeq.yPrime(cache[i].t + (stepSize / 2), cache[i].y + (stepSize / 2) * cache[i].kn1)
            cache[i].kn3    = diffeq.yPrime(cache[i].t + (stepSize / 2), cache[i].y + (stepSize / 2) * cache[i].kn2)
            cache[i].kn4    = diffeq.yPrime(cache[i].t + stepSize, cache[i].y + stepSize * cache[i].kn3)
            cache[i].yavg   = cache[i].y + (stepSize / 6) * (cache[i].kn1 + 2 * cache[i].kn2 + 2 * cache[i].kn3 + cache[i].kn4)
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                 |y                 |kn1               |kn2               |kn3               |kn4               |y+n+1             ")
        print("----|------------------+------------------+------------------+------------------+------------------+------------------+------------------")
    
        for i in 0..<cache.count {
            print(String(format: "%04d|%018f|%018f|%018f|%018f|%018f|%018f|%018f", i, cache[i].t, cache[i].y, cache[i].kn1, cache[i].kn2, cache[i].kn3, cache[i].kn4, cache[i].yavg))
        }
    }
    
}
