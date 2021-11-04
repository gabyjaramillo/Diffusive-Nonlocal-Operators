function u = AnalyticSolution()

    syms x y c1

    c1=sym(1);
    iif1 = (c1-x)*atan(-c1) + (x-c1)*atan(x-c1) + (1/2)*log(c1^2+1) - (1/2)*log((x-c1)^2+1);

    c2=-c1;
    iif2 = (c2-x)*atan(-c2) + (x-c2)*atan(x-c2) + (1/2)*log(c2^2+1) - (1/2)*log((x-c2)^2+1);

    c3=0;
    iif3 = (c3-x)*atan(-c3) + (x-c3)*atan(x-c3) + (1/2)*log(c3^2+1) - (1/2)*log((x-c3)^2+1);

    iif = iif3 - (1/2)*iif1 - (1/2)*iif2; 
%     g=simplify(diff(iif,x,2))

    f3 = 1/(1+(x)^2);
    f2 = 1/(1+(x-c2)^2);
    f1 = 1/(1+(x-c1)^2);

    f = f3 - (1/2)*f1 - (1/2)*f2;

%     simplify(f-g);

    sh = c1*atan(c1) - log(c1^2 + 1)/2;

    % assume(c1>0);
    % limit(iif,x,-inf)


    u = f - iif + sh;
    
%     taylor(u,x,inf, 'Order', 6)

%     figure
%     fplot(u,[-2 2])
%     hold on;
%     fplot(f, [-2 2])
end

% Alternative form of solution. The double integral is calculated from
% negative infinty.
%
% syms x y z c1
% 
% assume(c1 > 0);
% % c1=sym(1); 
% c2=-c1;
% 
% f3 = 1/(1+(x)^2);
% f2 = 1/(1+(x-c2)^2);
% f1 = 1/(1+(x-c1)^2);
% 
% f = f3 - (1/2)*f1 - (1/2)*f2;
% 
% iif = int(int(f,x,-inf,y),y,-inf,z);
% 
% iif2 = subs(iif,z,x);
% 
% u = f - iif2;

