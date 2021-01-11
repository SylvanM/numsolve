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

Now we can create the actual solver object, provided we give it the initial condition for `y(0)`:

```swift
let solver = GeneralSolver(eq, y0: 1)
```

Now we're ready to start solving! We're going to do a simple Euler approximation:

```swift
let eq = FirstOrderDE { 3 + $0 - $1 }
let solver = GeneralSolver(eq, y0: 1)

solver.euler(n: 8, stepSize: 0.05) // prints the table with each n steps for the Euler numerical method.
```

Using other approximation methods is simple:

```swift
solver.backwardEuler(n: 8, stepSize: 0.05)
solver.adamsMoulton(n: 40, stepSize: 0.05)
```

Here is a list of all available numerical methods:

- Euler's Method
- Backward Euler
- Improved Euler
- Runge Kutta (4th Order)
- Adams Bashforth
- Adams Moulton
- Backward Differentiation
- Predictor-Corrector
