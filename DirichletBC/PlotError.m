% Plot the error
clear;

% Load Date
f1 = load('Data/Run1_Mesh.mat');
f2 = load('Data/Run2_Mesh.mat');
f3 = load('Data/Run3_Mesh.mat');

% Set h-values;
h1 = 2*(f1.L)./f1.par.contPar.contParValues;
h2 = 2*(f2.L)./f2.par.contPar.contParValues;
h3 = 2*(f3.L)./f3.par.contPar.contParValues;

% Plots
plot(h1,f1.error,'-x','markersize',10,'linewidth',2)
hold on;
plot(h2,f2.error,'-o','markersize',10,'linewidth',2)
hold on;
plot(h3,f3.error,'-*','markersize',10,'linewidth',2)
hold on;
plot(h1,h1.^2,'--','markersize',10,'linewidth',2)

% Plot details
set(gca, 'fontsize',18);
set(gca, 'XScale', 'log')
set(gca, 'Xdir','reverse')
set(gca, 'YScale', 'log')
axis square

xlabel('h') 
ylabel('Error')

legend({'L=2', 'L=5', 'L=10','O(h^2)'},'Location','southwest')
legend('boxoff')

