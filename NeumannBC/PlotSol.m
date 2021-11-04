% Plot solution and forcing function

clear;

% Anayltic Solution
% ui = @(x) (x > 1 | x < -1).*   ( 1./(x.^4 + 10^-20) - 1./(6*x.^2+ 10^-20)) + ...
%              (x<= 1 & -1 <= x).*  ( x.^2 - ((x.^2 - 3).*(x - 1).*(x + 1))/12 - 5/6 ) ;
ui1 = @(x) (x > 1 | x < -1).*   ( 1./(x.^4 + 10^-20) - 1./(6*x.^2+ 10^-20));
ui2 = @(x) (x< 1 & -1 < x).*  ( x.^2 - ((x.^2 - 3).*(x - 1).*(x + 1))/12 - 5/6 ) ;
% Forcing Function
fi = @(x) (x < -1).*           1./(x.^4 + 10^(-20)) + ...
          (x > 1).*            1./(x.^4 + 10^(-20)) + ...
          (-1 <= x).*(x <= 1).*    ((x/1).^2-2/3);
fi1 = @(x) (x < -1).*           1./(x.^4 + 10^(-20));
fi2 = @(x) (x > 1).*            1./(x.^4 + 10^(-20));
fi3 = @(x) (-1 < x).*(x < 1).*    ((x/1).^2-2/3);
% Domain
% x = [-5 :.01:5]';
x1 = [-5:.01:-1-.01]';
x2 = [-1+.01: .01:1-.01]';
x3 = [1+.01:.01:5]';

% f= fi(x); u = ui(x);

plot(x1,ui1(x1),'k','linewidth',2,'MarkerIndices', 1:100:length(x1))
hold on;
plot(x3,ui1(x3),'k','linewidth',2,'MarkerIndices', 1:100:length(x3))
hold on;
p1 = plot(x2,ui2(x2),'k','linewidth',2,'MarkerIndices', 1:100:length(x2));
hold on;
p2 = plot(x1,fi1(x1),'-xr','markersize',10,'linewidth',2,'MarkerIndices', [1:100:length(x1) 400]);
hold on;
plot(x3,fi2(x3),'-xr','markersize',10,'linewidth',2,'MarkerIndices', 1:99:length(x3))
hold on;
plot(x2,fi3(x2),'-xr','markersize',10,'linewidth',2,'MarkerIndices', 1:99:length(x2))
set(gca, 'fontsize',18);
axis square
xlabel('x') 
legend([p1, p2],{'u(x)','f(x)'},'Location','southwest')
legend('boxoff')