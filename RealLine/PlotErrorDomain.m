clear;

f1 = load('Data/Run1_Domain.mat');
f2 = load('Data/Run2_Domain.mat');
f3 = load('Data/Run3_Domain.mat');

figure;
plot(f1.L,f1.error,'-x','markersize',10,'linewidth',2)
hold on;
plot(f2.L,f2.error,'-o','markersize',10,'linewidth',2)
hold on;
plot(f3.L,f3.error,'-*','markersize',10,'linewidth',2)
hold on;
plot(f1.L,f1.L.^-2,'--','markersize',10,'linewidth',2)

set(gca, 'fontsize',18);
set(gca, 'XScale', 'log')
% set(gca, 'Xdir','reverse')
set(gca, 'YScale', 'log')
axis square

xlabel('L') 
ylabel('Error')

legend({'h=0.5', 'h=0.05', 'h=0.005','O(L^{-2})'},'Location','southwest')
legend('boxoff')