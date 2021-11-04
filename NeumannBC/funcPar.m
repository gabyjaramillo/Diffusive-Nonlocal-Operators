function funcPar = funcPar(par)
% This creates all the necessary parameters and pieces of the nonlocal
% extended Dirichlet function.


% Rename parameters for convience
spatPar = par.spatPar;
L = spatPar.L;
M = spatPar.M;
x = spatPar.x;
xb = spatPar.xb;

Lw = 2*L;
h = Lw/M;

p = 2;

%%%%%
% Define Kernel
%%%%%

nu = @(y) (1/2)*exp(-abs(y));   % Kernel
Fi = @(y) (1/2)*exp(-abs(y));    % Define second antiderivative
Fip = @(y) -(1/2)*sign(y).*exp(-abs(y)); % Define first antiderivative

funcPar.F = Fi(xb);
funcPar.Fp = Fip(xb);

%%%%%
% Define Forcing Function
%%%%%

% Lp = 2; a = 5/16;
% Lp = 1; a = 0;
% fi = @(x) (x < -Lp).*           -1./(x.^4 + 10^(-20)) + ...
%           (x > Lp).*            -1./(x.^4 + 10^(-20)) + ...
%           (-Lp <= x).*(x <= Lp).*    ((x/Lp).^2-a);

Lp = 1; a = 2/3;
fi = @(x) (x < -Lp).*           1./(x.^4 + 10^(-20)) + ...
          (x > Lp).*            1./(x.^4 + 10^(-20)) + ...
          (-Lp <= x).*(x <= Lp).*    ((x/Lp).^2-a);

funcPar.f = fi(x);

%%%%%
% Calculate Corresponding Integrals
%%%%%

funcPar.f1 = (1/2)*(1/h^2)*(2 - exp(-h)*(h^2 + 2*h + 2));
funcPar.A = exp(-Lw);

%%%%%
% Define asymptotic form and corresponding Integral
%%%%%


% For u ~ sech(y);
% g1 = @(y) sech(y)/sech(-L);
% g2 = @(y) sech(y)/sech(L);
% Bi1 = @(x) (1/2)*exp(x).*log(exp(-2*Lw)+exp(2*x)) - exp(x).*x;
% Bi2 = @(x) (1/2)*exp(-x).*log(exp(-2*Lw)+exp(-2*x)) + exp(-x).*x;
% 
% par.B1 = Bi1(xb)/sech(-L);
% par.B2 =Bi2(xb)/sech(-L);

% For u ~ L^p/|y|^p;
g1 = @(y) L^p./abs(y).^p;
g2 = @(y) L^p./abs(y).^p;
Bi1 = @(x) L^p.*(1/2).*exp(x).*(1./(Lw+x).^(p-1)).*double(expint(sym(p),Lw+x));
Bi2 = @(x) L^p.*(1/2).*exp(-x).*(1./(Lw-x).^(p-1)).*double(expint(sym(p),Lw-x));

funcPar.B1 = Bi1(x);
funcPar.B2 = Bi2(x);

%%%%%
% Define the omega_i
%%%%%

omega(1) = funcPar.f1 - Fip(h) +(Fi(2*h) -Fi(h))/h;
omega(2:M-1,1) = (1/h)*(Fi(h*(2:M-1)' + h)-...
                    2*Fi(h*(2:M-1)') + Fi(h*(2:M-1)' - h));
omega(M) = Fip(h*M) + (Fi((M-1)*h) - Fi(M*h))/h;

funcPar.omega = [omega(M:-1:1); 0; omega];

%%%%%
% Define the c_i
%%%%%

funcPar.c1 = sum(funcPar.omega);

for i = -M/2:M/2         % There's a better way to do this.
    funcPar.c2(i+M/2+1,1)=0;                
    for j = -M:i-M/2-1
        funcPar.c2(i+M/2+1) = funcPar.c2(i+M/2+1) + g1((i-j)*h).*funcPar.omega(j+M+1);
    end
end

for i = -M/2:M/2         
    funcPar.c3(i+M/2+1,1)=0;                
    for j = i+M/2+1:M
        funcPar.c3(i+M/2+1) = funcPar.c3(i+M/2+1) + g2((i-j)*h).*funcPar.omega(j+M+1);
    end
end

%%%%%
% Define the matrix w_hat
%%%%%

funcPar.wh = toeplitz(funcPar.omega(M+1:end),funcPar.omega(M+1:-1:1));



%%%%%
% Define system
%%%%%

L = funcPar.c1*eye(M+1,M+1) - funcPar.wh + funcPar.A*eye(M+1,M+1);  % Matrix
L(:,1) = L(:,1) - funcPar.c2 - funcPar.B1;
L(:,M+1) = L(:,M+1) - funcPar.c3 - funcPar.B2;

funcPar.L = L;

end

