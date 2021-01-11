//
//  ImprovedEuler.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/9/20.
//

import Foundation

class ImprovedEuler: NumericalMethod {
    
    typealias TableRow = (t: Float80, y: Float80, yp: Float80, nextyp: Float80, avg: Float80, yavg: Float80)
    
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
        
        cache += [TableRow](repeating: (t: .nan, y: 0, yp: 0, nextyp: 0, avg: 0, yavg: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            cache[i].t      = Float80(i) * stepSize
            cache[i].y      = i == 0 ? y0 : cache[i - 1].yavg
            cache[i].yp     = diffeq.yPrime(cache[i].t, cache[i].y)
            cache[i].nextyp = diffeq.yPrime(cache[i].t + stepSize, cache[i].y + stepSize * cache[i].yp)
            cache[i].avg    = (stepSize * (cache[i].yp + cache[i].nextyp)) / 2
            cache[i].yavg   = cache[i].y + cache[i].avg
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                |y                |y'               |f(tn+h, y+hy')   |(h/2)(fn + f_n+1)| y + that      ")
        print("----|-----------------+-----------------+-----------------+-----------------+-----------------+---------------")
    
        for i in 0..<cache.count {
            print(String(format: "%04d|%.15f|%.15f|%.15f|%.15f|%.15f|%.15f", i, Double(cache[i].t), Double(cache[i].y), Double(cache[i].yp), Double(cache[i].nextyp), Double(cache[i].avg), Double(cache[i].yavg)))
        }
    }
    
}
