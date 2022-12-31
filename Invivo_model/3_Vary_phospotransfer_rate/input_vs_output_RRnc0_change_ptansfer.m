clear
close all

load('Fit_all_2.mat','par2')

%%

K1 = 5*10^5;
PT = 1;
Time = 10^8;
tau = 500;
k_deg_I = 1/tau;
k_pstase = 10^-3;

%%
HK1_unact       = 10;
RR1             = 100;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1;


II = logspace(0,10,30);
II2 = logspace(0,10,50);

Output_intg1 = zeros(length(II),1);
Output1 = zeros(length(II),1);
for ii = 1:length(II)
    Input = II(ii);
    IC(end) = Input;
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
par2_org = par2;
%%
for kk = [0.75 0.5 0.25]

HK1_unact       = 10;
RR1             = 100;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1;

par2(2)=par2_org(2)+log10(kk);

Output_intg2 = zeros(length(II),1);
Output2 = zeros(length(II),1);
for ii = 1:length(II)
    Input = II(ii);
    IC(end) = Input;
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
a1 = legend({'pt_{rate} = k_{p}^{RR}','pt_{rate} = 0.75.k_{p}^{RR}','pt_{rate} = 0.5.k_{p}^{RR}','pt_{rate} = 0.25.k_{p}^{RR}'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('Input signal (I_0)')
ylabel('Maximal output (O_{max})')
xlim([10^0 10^10]);
xticks(10.^[0 2 4 6 8 10])
set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,['I_vs_Omax_ptransfer.pdf'],'-dpdf','-r300')
savefig(h1,['I_vs_Omax_ptransfer.fig'])

figure(2)
a1 = legend({'pt_{rate} = k_{p}^{RR}','pt_{rate} = 0.75.k_{p}^{RR}','pt_{rate} = 0.5.k_{p}^{RR}','pt_{rate} = 0.25.k_{p}^{RR}'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('Input signal (I_0)')
ylabel('Cumulative output (O_{tot})')
xlim([10^0 10^10]);
xticks(10.^[0 2 4 6 8 10])
set(h2,'Units','inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h2,['I_vs_Otot_ptransfer.pdf'],'-dpdf','-r300')
savefig(h2,['I_vs_Otot_ptransfer.fig'])