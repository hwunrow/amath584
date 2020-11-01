x = 1.920:0.001:2.080;
y1 = (x-2).^9;
y2 = x.^9 - 18*x.^8 + 144*x.^7 - 672*x.^6 + 2016*x.^5 - 4032*x.^4 + 5376*x.^3 - 4608*x.^2 + 2304*x - 512;

figure;
subplot(1,2,1)
plot(x,y2);
title('RHS')
xlabel('1.920 \leq x \leq 2.080')

subplot(1,2,2)
plot(x,y1);
title('LHS')
xlabel('1.920 \leq x \leq 2.080');
