clear

load(['Fit_all_1.mat']);

p = length(par2);
nRes = length(x_data);
yExp = y_data./HK1s_0;
yModel = obj_3(par,x_data)./HK1s_0;
lnL = 0.5 * (-nRes * (log(2*pi) + 1 - log(nRes) + log(sum((yExp(:)-yModel(:)).^2))));
AIC = 2*p - 2*lnL;