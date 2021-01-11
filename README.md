# numsolve
Tool for solving differential equations using numerical methods

Hello all!

This is a tool for computing numerical methods for systems of differential first order differential equations, or second order equations. I originally made this to complete a 
homework assignment, but I realized other people could benefit from this tool. It displays all the different "steps" in computing the numerical approximations in the form of a table.

## How to use

We'll be walking through the steps for approximating the first order linear differential equation: `y' = 3 + t - y`

First, we need to create the equation in code.

```swift
let eq = FirstOrderDE { 3 + $0 - $1 }
```

Inside the closure is where you define `y'`. $0 represents `t`, and $1 represents `y`.
