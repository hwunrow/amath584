%% read in images

clear

rootdir = "C:\Users\hyone\Google Drive (hwunrow@uw.edu)\School\AMATH584\repos\amath584\hw5\data\yalefaces_cropped\CroppedYale";
files = dir(fullfile(rootdir, '**\*.*pgm'));

m = 192*168;
n = 2414;
A = zeros(m, n);

i = 1;
for ff=files'
  u = imread(fullfile(ff.folder, ff.name));
  M = reshape(double(u),m, 1);
  A(:,i) = M;
  i = i+1;
end

clear('M','u','files','ff');

%% 2(a)
[U,S,V] = svd(A,'econ');

corr = A'*A;
v0 = randn(n,1);
v = v0/norm(v0);

for i = 1:100
    v = corr*v/norm(corr*v);
end

%%
figure(1); hold on
plot(v, 'b');
plot(V(:,1), 'r');

norm(v - V(:,1))

%% 2(b)
iters = [10,50,100,500];

K = max(iters);
Omega = randn(n,K); % random projections

principal_eig_vector = zeros(m,length(iters));
mode_error = zeros(1, length(iters));
spectrum_approx = zeros(m, length(iters));
for i=1:length(iters)
    k = iters(i);
    Y = A*Omega(:,1:k);
    [Q,R] = qr(Y,0);
    B = (Q')*A;
    [Uhat,Shat,Vhat]=svd(B,'econ');
    Uhat=Q*Uhat;
    principal_eig_vector(:,i) = Uhat(:,1);
    mode_error(i) = norm(Uhat(:,1:10)-U(:,1:10),inf)/norm(U(:,1:10),inf);
    spectrum_approx(1:k,i) = diag(Shat);
end

%% 2(c)

% first mode error
figure(1); hold on
plot(iters, mode_error, 'bo-')
xlabel("Number of random projectrions")
ylabel("$\|\hat{U} - U\|_{\infty} / \|U\|_{\infty}$",'Interpreter','latex')


% singular value spectrum
figure(2); hold on

true_spectrum = diag(S);
b1 = plot(true_spectrum(1:500), 'ko'); M1 = "True spectrum";
b2 = plot(spectrum_approx(1:10,1),'bo'); M2 = "10 random projection";
b3 = plot(spectrum_approx(1:50,2),'go'); M3 = "50 random projection";
b4 = plot(spectrum_approx(1:100,3),'mo'); M4 = "100 random projection";
b5 = plot(spectrum_approx(1:500,4),'co'); M5 = "500 random projection";

legend([b1;b2;b3;b4;b5], M1, M2, M3, M4, M5)
xlabel("k")
ylabel("\sigma_{k}")

% plot true and approximated eigenfaces
figure(3);
title('Principal eigenface approximations');
subplot(2,3,1), imshow(reshape(U(:,1),[192,168]), []);
xlabel('True principal eigenface');
subplot(2,3,2), imshow(reshape(principal_eig_vector(:,1),[192,168]), []);
xlabel('k =10');
subplot(2,3,3), imshow(reshape(principal_eig_vector(:,2),[192,168]), []);
xlabel('k = 50');
subplot(2,3,4), imshow(reshape(principal_eig_vector(:,3),[192,168]), []);
xlabel('k = 100');
subplot(2,3,5), imshow(reshape(principal_eig_vector(:,4),[192,168]), []);
xlabel('k = 500');

% plot them as vectors
figure(4);
subplot(1,2,1), plot(U(:,1), 'r');
xlabel('True principal eigenface');
subplot(1,2,2), plot(principal_eig_vector(:,4))
xlabel('k = 500');



