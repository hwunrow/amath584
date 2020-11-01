m = 200;
step_size = 10;

qr_errors = zeros(1,4);
orth_errors = zeros(1,4);

i = 1;
for n = 50:step_size:m
    A = rand(m,n);
    I = eye(m);
    qr_errors(i,1) = cond(A);
    orth_errors(i,1) = cond(A);
    
    % Modified Gram Schmidt
    [Q1,R1] = MGS(A);
    qr_errors(i,2) = norm(Q1*R1-A,inf)/norm(A,inf);
    orth_errors(i,2) = norm(Q1'*Q1-eye(n),inf);
    % Professor Kutz code
    [Q2,R2] = qrfactor(A);
    qr_errors(i,3) = norm(Q2*R2-A,inf)/norm(A,inf);
    orth_errors(i,3) = norm(Q2'*Q2-I,inf);
    % MATLAB algorithm
    [Q3,R3] = qr(A);
    qr_errors(i,4) = norm(Q3*R3-A,inf)/norm(A,inf);
    orth_errors(i,4) = norm(Q3'*Q3-I,inf);

    i = i + 1;
end



figure(1); hold on

x = qr_errors(:,1);
y1 = qr_errors(:,2);
y2 = qr_errors(:,3);
y3 = qr_errors(:,4);

a1 = plot(x,y1,'-o'); M1 = 'Modified Gram Schmidt';
a2 = plot(x,y2,'-o'); M2 = 'qrfactor.m';
a3 = plot(x,y3,'-o'); M3 = 'MATLAB algorithm';

legend([a1;a2;a3], M1, M2, M3)
xlabel("cond(A)")
ylabel("QR_{error}")

figure(2); hold on

orth_y1 = orth_errors(:,2);
orth_y2 = orth_errors(:,3);
orth_y3 = orth_errors(:,4);

a1 = plot(x,orth_y1,'-o'); M1 = 'Modified Gram Schmidt';
a2 = plot(x,orth_y2,'-o'); M2 = 'qrfactor.m';
a3 = plot(x,orth_y3,'-o'); M3 = 'MATLAB algorithm';

legend([a1;a2;a3], M1, M2, M3)
xlabel("cond(A)")
ylabel("Orth_{error}")

%%
% singular matrix
A = randn(50);
A(:,end) = A(:,1);
I = eye(50);
sing_qr_error = zeros(1,3);
sing_orth_error = zeros(1,3);

 % Modified Gram Schmidt
[Q1,R1] = MGS(A);
sing_qr_error(1) = norm(Q1*R1-A,inf)/norm(A,inf);
sing_orth_error(1) = norm(Q1'*Q1-I,inf);
% Professor Kutz code
[Q2,R2] = qrfactor(A);
sing_qr_error(2) = norm(Q2*R2-A,inf)/norm(A,inf);
sing_orth_error(2) = norm(Q2'*Q2-I,inf);
% MATLAB algorithm
[Q3,R3] = qr(A);
sing_qr_error(3) = norm(Q3*R3-A,inf)/norm(A,inf);
sing_orth_error(3) = norm(Q3'*Q3-I,inf);

fprintf('\n                    MGS   Householder  MATLAB \n')
fprintf('QR error      %10.2e %10.2e %10.2e\n',sing_qr_error)
fprintf('Orthogonality %10.2e %10.2e %10.2e\n',sing_orth_error)


