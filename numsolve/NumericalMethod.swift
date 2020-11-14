//
//  NumericalMethod.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/9/20.
//

import Foundation

protocol NumericalMethod {
    
    associatedtype TableRow
    
    // MARK: Properties
    
    /// The y value at t = 0
    var y0: Float80 { get }
    
    /// The step size
    var stepSize: Float80 { get }
    
    /// The differential Equation
    var diffeq: FirstOrderDE { get }
    
    /// The table of results
    var cache: [TableRow] { get }
    
    // MARK: Functions
    
    /// The `nth` prediction for `y`
    @discardableResult func predict(n: Int) -> Float80
    
    /// Presents the cache table
    func showCacheTable()
    
    
}
