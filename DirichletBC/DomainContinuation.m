%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve the system for a range of domain sizes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

h = 5*10^(-3);  % Fix the mesh size.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Parameter Values To Do Continuation Over
contPar = 'L';                 
contParValues = 1:15;
uu = cell(1,length(contParValues));
xx = cell(1,length(contParValues));

% Double check the choice for h leads to an even M value.
if any(mod(2*contParValues/h,2)) ~= 0
    disp('M is not even');
    return;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve System Over Range of Values
i = 0;
for cp = contParValues
    i = i+1
    par.spatPar = spatPar(cp,2*cp/h);
    par.funcPar = funcPar(par);
    uu{i} = par.funcPar.L\par.funcPar.b;
    xx{i} = par.spatPar.x;
end

par.contPar.contPar = contPar;
par.contPar.contParValues = contParValues;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Error With Reference To Known Solution
g = matlabFunction(AnalyticSolution());

i = 0;
for cp = 1:length(contParValues)
    i = i+1;
    error(i) = max(abs(g(xx{i}) - uu{i}));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Initial File

save('Data/Run3_Domain.mat','uu','xx','h','error','par','-v7.3'); 