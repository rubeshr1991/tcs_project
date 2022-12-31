% T test for RR difference

load('Fit1_data_new.mat','RR1s_data')
x=RR1s_data;
load('Fit2_data_new.mat','RR1s_data')
y=RR1s_data;

% [h,p,ci,stats]=ttest2(x(2:end),y(2:end), 'Vartype', 'unequal')
[h,p,ci,stats]=ttest2(x(2:end),y(2:end), 'Vartype', 'unequal','Tail','right')


load('PdtaR-RFP_data_new.mat','RR1s_data')
z=RR1s_data;

% [h,p,ci,stats]=ttest2(x(2:end),y(2:end), 'Vartype', 'unequal')
[h,p,ci,stats]=ttest2(x(2:end),z(2:end), 'Vartype', 'unequal','Tail','right')