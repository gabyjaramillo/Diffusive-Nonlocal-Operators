%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve the system for a range of domain sizes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

L = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Parameter Values To Do Continuation Over
contPar = 'M';

exp = [0:.1:3];
h = 10.^(-exp);                             % This choice will make the spacing constant in an
                                            % error vs log(h) plot.

contParValues = 2*L./h;                     % The M values for those select h values.
contParValues = 2*round(contParValues/2);   % Adjust them so that all the M values are now even.

uu = cell(1,length(contParValues));
xx = cell(1,length(contParValues));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve System Over Range of Values
i = 0;
for cp = contParValues
    i = i+1
    par.spatPar = spatPar(L,cp);
    par.funcPar = funcPar(par);
    uu{i} = par.funcPar.L\par.funcPar.f;
    xx{i} = par.spatPar.x;
end

par.contPar.contPar = contPar;
par.contPar.contParValues = contParValues;
par.funcPar =[];    % No reason to save if you don't need it.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (Optional) Calculate Error With Reference To Known Solution
g = matlabFunction(AnalyticSolution());

i = 0;
for cp = 1:length(contParValues)
    i = i+1;
    error(i) = max(abs(g(xx{i}) - uu{i})); 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Initial File

save('Data/Run3_Mesh.mat','uu','xx','L','error','par','-v7.3'); 