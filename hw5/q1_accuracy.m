%% 1(a)
% set seed to make results reproducible
rng(1994);
% generate random, symmetric matrix
m = 10;
A = randn(m);
A = A - tril(A,-1) + triu(A,1)';
[V,D] = eigs(A,m);

max_eig = max(D, [], 'all');

%% 1(b)

v0 = randn(m,1);
accuracy = power_iteration(A,v0,60) / max_eig;

figure(1);
plot(accuracy);
xlabel("iterations")
ylabel("accuracy")


%% 1(c)
noise = randn(m,m);
V0 = V + 10^(-1)*noise;
L = diag(D);

num_iters = 10;
accuracy = zeros(m,num_iters+1);
for i=1:m
    v0 = V0(:,i);
    v0 = v0/norm(v0);
    true_lam = L(i);
    accuracy(i,:) = abs(rayleigh_quotiet_iteration(A,v0,num_iters)-true_lam);
end

accuracy = accuracy(:,2:num_iters+1);
figure(2);
plot(accuracy');
xlabel("iterations")
ylabel("$\|\hat{\lambda} - \lambda\|$", 'Interpreter','latex')

% RQI with aribitrary complex initial vector
v0 = randn(m,1);
v0 = v0/norm(v0);
num_iters = 20;
lam_hat = rayleigh_quotiet_iteration(A,v0,num_iters);
lam_hat = lam_hat(~isnan(lam_hat));
[c,id] = min(abs(L - lam_hat(end)));
accuracy = abs(lam_hat - L(id));

figure(3);
plot(accuracy');
xlabel("iterations")
ylabel("$\|\hat{\lambda} - \lambda\|$", 'Interpreter','latex')

%% 1(d)
% set seed to make results reproducible
rng(2020);
% generate random matrix
m = 10;
B = randn(m);
[V,D] = eigs(B,m);
max_eig = max(D, [], 'all');

% plot eigenvalues
figure(4);
plot(diag(D), 'o');
xlabel("Re")
ylabel("Im")

% power iteration method
v0 = complex(randn(m,1), randn(m,1));
accuracy = abs(power_iteration(B,v0,500)-max_eig);

figure(5);
plot(accuracy);
xlabel("iterations")
ylabel("$\|\hat{\lambda} - \lambda\|$", 'Interpreter','latex')

% rayleigh quotient iteration
noise = complex(randn(m,m),randn(m,m));
V0 = V + 10^(-3)*noise;
L = diag(D);

num_iters = 10;
accuracy = zeros(m,num_iters+1);
for i=1:m
    v0 = V0(:,i);
    v0 = v0/norm(v0);
    true_lam = L(i);
    accuracy(i,:) = abs(rayleigh_quotiet_iteration(B,v0,num_iters)-true_lam);
end

accuracy = accuracy(:,2:num_iters+1);
figure(6);
plot(accuracy');
xlabel("iterations")
ylabel("$\|\hat{\lambda} - \lambda\|$", 'Interpreter','latex')

% RQI with aribitrary complex initial vector
v0 = complex(randn(m,1),randn(m,1));
v0 = v0/norm(v0);
num_iters = 20;
lam_hat = rayleigh_quotiet_iteration(B,v0,num_iters);
lam_hat = lam_hat(~isnan(lam_hat));
[c,id] = min(abs(L - lam_hat(end)));
accuracy = abs(lam_hat - L(id));

figure(7);
plot(accuracy');
xlabel("iterations")
ylabel("$\|\hat{\lambda} - \lambda\|$", 'Interpreter','latex')
