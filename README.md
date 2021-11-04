# Diffusive-Nonlocal-Operators
Authors: Gabriela Jaramillo, Loic Cappanera, Cory Ward

The folders in this repository contain the code developed in the paper:
"Numerical Methods for a Diffusive Class of Nonlocal Operators." Journal of Scientific Computing 88.1 (2021): 1-40.

The main motivation for the paper came from models in ecology where the way species disperse can be modeled using a convolution operator.
This models often assume that the kernel describing this nonlocal process is exponentially localized, with finite second moment.
The code developed here can handle 1-d problems posed on bounded domains with nonlocal Dirichlet and nonlocal Neumann boundary conditions,
as well as approximating problems posed on the whole real line.

We consider kernels that do not have compact support and are exponentially localized. For problems posed on bounded domains with
Dirichlet b.c. we allow for kernels that take on negative values, but require that they have a positive tail. In the case of problems posed
on the whole real line or with nonlocal Neumann b.c. we assume the kernels are non-negative.

For a complete description of the code, please see our paper. The code is an extension of Huang and Oberman's paper:
"Numerical methods for the fractional Laplacian: A finite difference-quadrature approach." SIAM J. Numer. Anal. 52(6), 3056–3084 (2014).
We implemented the code in Matlab, but we hope that the description in the paper is enough to help people implement it in other languages.

## Here we present a quick summary of the contents of each folder:

spatPar: Computes necessary parameters to define the system and domain.

funcPar: Defines the system and generates all necessary matrices.

AnalyticSolution: Contains the known, analytic solution for the problem under consideration.

DomainContinuation: Solves the system for a range of L (domain) values.

MeshContinuation: Solves the system for a range of h (mesh size) values.

PlotError: Plots the error as a function of L or h (see the other figure directories).

PlotSol: Plots the analytic solution and forcing function.
