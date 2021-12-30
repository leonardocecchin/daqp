%% Init 
addpath ../interfaces/matlab/
%% Random qp 
%Generate problem 
n=10;
m = 100;

Mr = randn(n);
H =  Mr'*Mr;
f = randn(n,1);
A = randn(m,n);
b = rand(m,1);

R = chol(H);
M = A/R;
v = R'\f;
d = b+M*v;

epsilon = 1e-8;
%epsilon =  0;
% Solve and compare with quadprog solution

sense = zeros(m,1,'int32') ;
[x_daqp,fval_x_daqp, flag, time_daqp] =  daqpmex_quadprog(H',f,A',b,sense,0);
[x_prox,fval_x_daqp, flag, time_prox] =  daqpmex_quadprog(H',f,A',b,sense,epsilon);
[xref,fval_ref] = quadprog(H,f,A,b);
err=norm(x_daqp-xref)

fval_daqp = 0.5*x_daqp'*H*x_daqp+f'*x_daqp;
fval_prox = 0.5*x_prox'*H*x_prox+f'*x_prox;

time_daqp-time_prox
fval_daqp-fval_prox
