% Plot solution and forcing function

clear;

% Anayltic Solution
ui = @(y) sech(y);

% Forcing Function
fi = @(y) sech(y) - (1/2)*exp(-y).*log(1+exp(2*y))-...
        (1/2)*exp(y).*log(1+exp(2*y)) + y.*exp(y);

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
