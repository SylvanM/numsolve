//
//  PredictorCorrector.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/15/20.
//

import Foundation

class PredictorCorrector: NumericalMethod {
    
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
        
        cache += [TableRow](repeating: (t: .nan, y: 0, f: .nan, nexty: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            cache[i].t = Float80(i) * stepSize
            cache[i].y = i == 0 ? y0 : cache[i - 1].nexty
            
            if cache[i].f.isNaN {
                cache[i].f = diffeq.yPrime(cache[i].t, cache[i].y)
            }
            
            
            var total = [
                55  * cache[i - 0].f,
                -59 * cache[i - 1].f,
                37  * cache[i - 2].f,
                -9  * cache[i - 3].f
            ].reduce(0, +)
            
            let yNextEstimate = cache[i].y + (stepSize / 24) * total
            
            let fNext = diffeq.yPrime(cache[i].t + stepSize, yNextEstimate)
            
            // go ahead and pass this forward to the next step to save computation
            if i < n { cache[i + 1].f = fNext }
            
            // now do moulton but using fNext
            
            total = [
                9  * fNext,
                19 * cache[i].f,
                -5 * cache[i - 1].f,
                cache[i - 2].f
            ].reduce(0, +)
            
            cache[i].nexty = cache[i].y + (stepSize / 24) * total
            
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                |y                |f_n              |next y           ")
        print("----|-----------------+-----------------+-----------------+-----------------")
        
        for i in 0..<cache.count {
            print(String(format: "%04d|%.15f|%.15f|%.15f|%.15f", i, Double(cache[i].t), Double(cache[i].y), Double(cache[i].f), Double(cache[i].nexty)))
        }
    }
    
}
