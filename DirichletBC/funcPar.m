function  funcPar = funcPar(par)
% This creates all the necessary parameters and pieces of the nonlocal
% Dirichlet function (i.e. all the parts of the collocation method).

% Rename parameters for convience
spatPar = par.spatPar;
L = spatPar.L;
M = spatPar.M;
x = spatPar.x;      % BVP Domain [-Lx, Lx]
xb = spatPar.xb;    % Computational Domain [-Lw, Lw]

Lw = 2*L;
h = Lw/M;


%%%%%
% Define Kernel
%%%%%

nu = @(y) (1/2)*exp(-abs(y));   % Kernel
Fi = @(y) (1/2)*exp(-abs(y));    % Define second antiderivative
Fip = @(y) -(1/2)*sign(y).*exp(-abs(y)); % Define first antiderivative

F = Fi(xb);
Fp = Fip(xb);

%%%%%
% Define Forcing Function
%%%%%

fi = @(y) sech(y) - (1/2)*exp(-y).*log(1+exp(2*y))-...
        (1/2)*exp(y).*log(1+exp(2*y)) + y.*exp(y);


f = fi(x);

%%%%%
% Calculate Corresponding Integrals
%%%%%

f1 = (1/2)*(1/h^2)*(2 - exp(-h)*(h^2 + 2*h + 2));
A = exp(-Lw);

%%%%%
% Define Dirichlet BC and corresponding Integral
%%%%%

g = @(y) sech(y);
Bi = @(x) (1/2)*exp(x).*log(exp(-2*Lw)+exp(2*x)) - exp(x).*x ...
        + (1/2)*exp(-x).*log(exp(-2*Lw)+exp(-2*x)) + exp(-x).*x;
B = Bi(x);

%%%%%
% Define the omega_i
%%%%%

omega(1) = f1 - Fip(h) +(Fi(2*h) -Fi(h))/h;
omega(2:M-1,1) = (1/h)*(Fi(h*(2:M-1)' + h)-...
                    2*Fi(h*(2:M-1)') + Fi(h*(2:M-1)' - h));
omega(M) = Fip(h*M) + (Fi((M-1)*h) - Fi(M*h))/h;

omega2 = [omega(M:-1:1); 0; omega];

%%%%%
% Define the c_i
%%%%%

c1 = sum(omega2);

for i = -M/2+1:M/2-1          % There's a better way to do this.
    c2(i+M/2,1)=0;                
    for j = -M:i-M/2
        c2(i+M/2) = c2(i+M/2) + g((i-j)*h).*omega2(j+M+1);
    end
end

for i = -M/2+1:M/2 -1         
    c3(i+M/2,1)=0;                
    for j = i+M/2:M
        c3(i+M/2) = c3(i+M/2) + g((i-j)*h).*omega2(j+M+1);
    end
end

%%%%%
% Define the matrix w_hat
%%%%%

wh = toeplitz(omega2(M+1:end-2),omega2(M+1:-1:3));


%%%%%
% Construct linear matrix and forcing term
%%%%%

L = c1*eye(M-1,M-1) - wh + A*eye(M-1,M-1);  % Matrix
b = c2 + c3 + f + B;

%%%%%
% Encapsulate into structure
%%%%%

funcPar.L = L;
funcPar.b = b;
funcPar.c1 = c1;
funcPar.c2 = c2;
funcPar.c3 = c3;
funcPar.wh = wh;
funcPar.A = A;
funcPar.B = B;
funcPar.f = f;
funcPar.M = M;
funcPar.omega=omega;
        
end



    
    
    
    
    
    
    