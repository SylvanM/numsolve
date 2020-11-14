//
//  FirstOrderLinear.swift
//  numsolve
//
//  Created by Sylvan Martin on 11/9/20.
//

import Foundation

/// A first order linear differential equation of the form
///
/// `y' + a(t)y = g(t)`
struct FirstOrderDE {
    
    /// The `y'` value for a particular `t` and `y`
    var yPrime: (_ t: Float80, _ y: Float80) -> Float80
    
}
