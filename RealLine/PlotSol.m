% Plot solution and forcing function

clear;

% Anayltic Solution
ui = matlabFunction(AnalyticSolution());

% Forcing Function
fi = @(y) 1./(1+y.^2) -(1/2)*1./(1+(y-1).^2) - (1/2)*1./(1+(y+1).^2);

% Domain
x = [-10 :.01:10]';

f= fi(x); u = ui(x);

plot(x,u,'linewidth',2,'MarkerIndices', 1:100:length(x))
hold on;
plot(x,f,'-x','markersize',5,'linewidth',2,'MarkerIndices', 1:100:length(x))

set(gca, 'fontsize',18);
axis square

xlabel('x') 

legend({'u(x)','f(x)'},'Location','northeast')
legend('boxoff')