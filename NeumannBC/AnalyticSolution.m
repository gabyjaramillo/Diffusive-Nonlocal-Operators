function u = AnalyticSolution()

    % Forcing function
%     syms x L a
%     assume(L>0)
%     
%     f1 = piecewise(x < -L,  1/x^4,x > L,  1/x^4, -L <= x <= L, (x/L)^2-a);
%     g = int(f1,-inf,inf);
%    
%     a = solve( g==0,a);
%     
%     f1 = piecewise(x < -L,  1/x^4,x > L,  1/x^4, -L <= x <= L, (x/L)^2-a);
%     int(f1,-inf,inf)
%     int(x*f1,-inf,inf)
%     
%     b = 1;
%     f2 = subs(f1, L , b);
%     subs(a, L, b)
% %     
% %     fplot(f2, [-10, 10]);
%     
%     % Solution
%     syms w y
%     iif = int(int(f2,x,-inf,w),w,-inf,y);
%     iif = subs(iif, y , x);
%     u = f2 - iif;
%
%     figure
%     fplot(u,[-10 10],'-x')
%     hold on;
%     fplot(f2, [-10 10],'-o')


    % Logical Indexing
    
    u = @(x) (x > 1 | x < -1).*   ( 1./(x.^4 + 10^-20) - 1./(6*x.^2+ 10^-20)) + ...
             (x<= 1 & -1 <= x).*  ( x.^2 - ((x.^2 - 3).*(x - 1).*(x + 1))/12 - 5/6 ) ;

    

end
