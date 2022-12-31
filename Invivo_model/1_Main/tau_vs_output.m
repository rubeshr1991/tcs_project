clear
close all

load('Fit_all_2.mat','par2')

%%

K1 = 5*10^5;
PT = 1;
Time = 20000;
% tau = 500;
% k_deg_I = 1/tau;
Input = 1000;
k_pstase = 10^-3;

%%

HK1_unact       = 10;
RR1             = 100;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1; IC(end) = Input;

II = linspace(0.1,1000,10);
II2 = linspace(0.1,1000,50);

Output_intg1 = zeros(length(II),1);
Output1 = zeros(length(II),1);
for ii = 1:length(II)
    tau = II(ii);
    k_deg_I = log(2)/tau;
    [t1,y1]=ode15s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase); 
    Output_time1 = y1(:,6).^2./(K1+y1(:,6).^2)*PT;
    Output_intg1(ii) = trapz(t1,Output_time1);
%     Output1(ii) = y1(end,6).^2./(K1+y1(end,6).^2)*PT;
    Output1(ii) = max(Output_time1);
end

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(groot,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h1=figure(1);
set(h1,'position',[50 50 60*mm2pix 50*mm2pix])
hold on; box on 
set(gca, 'ColorOrder', [0 0 0]);
set(gca,'linestyleorder',{'-','--',':','-.'})
plot(II2,spline(II,Output1,II2));

h2=figure(2);
set(h2,'position',[50 50 60*mm2pix 50*mm2pix])
hold on; box on 
set(gca, 'ColorOrder', [0 0 0]);
set(gca,'linestyleorder',{'-','--',':','-.'})
plot(II2,spline(II,Output_intg1,II2));

%%
for kk = [1 5 10]


HK1_unact       = 10;
RR1             = 100;
RR2             = 100*kk;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1; IC(7) = RR2; IC(end) = Input;

Output_intg2 = zeros(length(II),1);
Output2 = zeros(length(II),1);
for ii = 1:length(II)
    tau = II(ii);
    k_deg_I = log(2)/tau;
    [t2,y2]=ode15s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase); 
    Output_time2 = y2(:,6).^2./(K1+y2(:,6).^2)*PT;
    Output_intg2(ii) = trapz(t2,Output_time2);
%     Output2(ii) = y2(end,6).^2./(K1+y2(end,6).^2)*PT;
    Output2(ii) = max(Output_time2);
end
figure(1);
plot(II2,spline(II,Output2,II2));

figure(2);
plot(II2,spline(II,Output_intg2,II2));

end
%%
figure(1)
a1 = legend({'RR_{nc} = 0','RR_{nc} = RR_c','RR_{nc} = 5RR_c','RR_{nc} = 10RR_c'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
% set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('Input duration (\tau)')
ylabel('Maximal output (O_{max})')
xlim([-400 10^3]);
set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,['tau_vs_Omax.pdf'],'-dpdf','-r300')
savefig(h1,['tau_vs_Omax.fig'])

figure(2)
a1 = legend({'RR_{nc} = 0','RR_{nc} = RR_c','RR_{nc} = 5RR_c','RR_{nc} = 10RR_c'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
% set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('Input duration (\tau)')
ylabel('Cumulative output (O_{tot})')
xlim([-200 10^3]);
set(h2,'Units','inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h2,['tau_vs_Otot.pdf'],'-dpdf','-r300')
savefig(h2,['tau_vs_Otot.fig'])