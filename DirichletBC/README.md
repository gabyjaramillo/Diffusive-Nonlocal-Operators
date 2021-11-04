Contains the code necessary to construct Figure 1. 

This is the Dirichlet problem with sech(x) boundary conditions.

Panel (b) no longer contains a plot of error vs L, but I've kept the 
function DomainContinuation in the file nonetheless.

A quick summary:

spatPar:	    Computes necessary parameters to define the system and domain.
funcPar:            Defines the system and generates all necessary matrices.

AnalyticSolution:   Contains the known, analytic solution for the problem under consideration.

DomainContinuation: Solves the system for a range of L (domain) values.
MeshContinuation:   Solves the system for a range of h (mesh size) values.

PlotError:          Plots the error as a function of L or h (see the other figure directories).
PlotSol:	    Plots the analytic solution and forcing function.