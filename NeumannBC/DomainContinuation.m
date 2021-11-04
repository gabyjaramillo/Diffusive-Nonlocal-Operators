%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve the system for a range of domain sizes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

h = 5*10^(-1);  % Because M needs to be even, this technically changes. No 
                % way around this because of finite point arithmetic.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Parameter Values To Do Continuation Over
contPar = 'L';

exp = [0:.1:1.65];
L = 10.^exp;

M = 2*L/h;
M = round(M/2)*2;
h = 2*L./M;         % Given the L and M values chosen, this is technically 
                    % the corresponding h values. Some variation will be
                    % seen but it should be to a smaller order than the 
                    % h value at the top of the page.

contParValues = L;
uu = cell(1,length(contParValues));
xx = cell(1,length(contParValues));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve System Over Range of Values
i = 0;
for cp = contParValues
    i = i+1
    par.spatPar = spatPar(cp,M(i));
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

i=0;
for cp = 1:length(contParValues)
    i = i+1;
    error(i) = max(abs(g(xx{i}) - uu{i})); 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Initial File

save('Data/Run1_Domain.mat','uu','xx','L','error','par','-v7.3'); 