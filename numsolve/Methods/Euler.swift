//
//  Euler.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/9/20.
//

import Foundation

class Euler: NumericalMethod {
    
    typealias TableRow = (t: Float80, y: Float80, yp: Float80, hyp: Float80, yhyp: Float80)
    
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
        
        cache += [TableRow](repeating: (t: .nan, y: 0, yp: 0, hyp: 0, yhyp: 0), count: (n + 1) - cache.count)
        
        for i in startIndex...n {
            cache[i].t      = Float80(i) * stepSize
            cache[i].y      = i == 0 ? y0 : cache[i - 1].yhyp
            cache[i].yp     = diffeq.yPrime(cache[i].t, cache[i].y)
            cache[i].hyp    = stepSize * cache[i].yp
            cache[i].yhyp   = cache[i].y + cache[i].hyp
        }
        
        return cache[n].y
    }
    
    func showCacheTable() {
        print("n   |t                |y                |y'               |hy'              |y + hy'          ")
        print("----+-----------------+-----------------+-----------------+-----------------+-----------------")
        
        for i in 0..<cache.count {
            print(String(format: "%04d|%.15f|%.15f|%.15f|%.15f|%.15f", i, Double(cache[i].t), Double(cache[i].y), Double(cache[i].yp), Double(cache[i].hyp), Double(cache[i].yhyp)))
        }
    }
    
}
