%% part (a)
rng(1994);
A1 = randn(50,49);
A2 = randn(100,99);
A3 = randn(500,499);
A4 = randn(1000,999);

conds1 = condition_remove_columns(A1);
conds2 = condition_remove_columns(A2);
conds3 = condition_remove_columns(A3);
conds4 = condition_remove_columns(A4);

figure(1); hold on
a1 = plot(1:48, conds1); M1 = 'm = 50';
a2 = plot(1:98, conds2); M2 = 'm = 100';
a3 = plot(1:498, conds3); M3 = 'm = 500';
a4 = plot(1:998, conds4); M4 = 'm = 1000';
legend([a1;a2;a3;a4], M1, M2, M3, M4)
ylabel("cond(A)")
xlabel("m - n")




%% part (b)
rng(1994)
m = 50;
A = randn(m);
B = A;
B(:,end) = A(:,1);
cond(B)
det(B)

% part (c)
noise = randn(m,1);
B = A;
condition_num = zeros(10,1);
for exp = 1:100
    ep = 10^(-exp);
    B(:,end) = A(:,1) + ep;
    condition_num(exp) = cond(B);
end

plot(1:100,condition_num, "--o")
xlabel("x where \epsilon = 10^{-x}")
ylabel("cond(A)")
    


%%  user-defined function
function conds = condition_remove_columns(A)
% iteratively removes columns of matrix A and computes condition number
    [~,n] = size(A);
    conds = zeros(1,n-1);
    i = 1;
    while(n ~= 1)
        conds(i) = cond(A);
        A(:,end) = [];
        i = i + 1;
        [~,n] = size(A);
    end
end
