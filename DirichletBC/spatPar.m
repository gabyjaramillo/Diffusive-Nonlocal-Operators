function spatPar = spatPar(L,M)
% Create spatial parameters

spatPar.L = L;                % BVP Domain [-Lx, Lx]
spatPar.M = M; 
h = 2*L/M;
spatPar.x = h*(-M/2+1:M/2-1)';                % BVP Domain [-Lx, Lx]
spatPar.xb = h*(-M:M)';         % Computational Domain [-Lw, Lw]  

end

