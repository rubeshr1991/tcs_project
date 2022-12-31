clear
load('Fit_all_2.mat','par2','ci_J')

Par = [10.^par2(1:end-1); par2(end)/10^4];
ci_J  = [10.^ci_J(1:end-1,:); ci_J(end,:)./10^4];