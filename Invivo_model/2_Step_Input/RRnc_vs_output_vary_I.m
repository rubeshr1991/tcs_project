clear
close all

load('Fit_all_2.mat','par2')

%%

K1 = 5*10^5;
PT = 1;
Time = 100000;
tau = 1000;
k_deg_I = log(2)/tau;
k_pstase = 10^-3;

%%

II = logspace(0,5,50);
II2 = logspace(0,5,50);

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(groot,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h1=figure(1);
set(h1,'position',[50 50 60*mm2pix 50*mm2pix])
hold on; box on 
set(gca, 'ColorOrder', [0 0 0]);
set(gca,'linestyleorder',{'-','--',':','-.'})

h2=figure(2);
set(h2,'position',[50 50 60*mm2pix 50*mm2pix])
hold on; box on 
set(gca, 'ColorOrder', [0 0 0]);
set(gca,'linestyleorder',{'-','--',':','-.'})

%%
for kk = [100 1000 10000]

    
HK1_unact       = 10;
RR1             = 100;
Input = kk;

IC = zeros(23,1); IC(1) = HK1_unact; IC(5) = RR1;


Output_intg2 = zeros(length(II),1);
Output2 = zeros(length(II),1);
for ii = 1:length(II)
    RR2 = II(ii);
    IC(7) = RR2;    
    [t2,y2]=ode15s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase,Input); 
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
a1=legend({'I_0 = 100','I_0 = 1000','I_0 = 10000'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('RR_{nc}/RR_c')
ylabel('Maximal output (O_{max})')
xlim([10^0 10^5]);
xticks(10.^[0 2 4])
set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,['RRnc_vs_Omax_vary_I.pdf'],'-dpdf','-r300')
savefig(h1,'RRnc_vs_Omax_vary_I.fig');

figure(2)
a1=legend({'I_0 = 100','I_0 = 1000','I_0 = 10000'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('RR_{nc}/RR_c')
ylabel('Cumulative output (O_{tot})')
xlim([10^0 10^5]);
xticks(10.^[0 2 4])
set(h2,'Units','inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h2,['RRnc_vs_Otot_vary_I.pdf'],'-dpdf','-r300')
savefig(h2,'RRnc_vs_Otot_vary_I.fig');