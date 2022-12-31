clear
close all

load('Fit_all_2.mat','par2')

%%

K1 = 5*10^5;
PT = 1;
Time = 20000;
tau = 500;
k_deg_I = 1/tau;
k_pstase = 0.001;

%%
HK1_unact       = 10;
HK1             = 0;
HK1_ATP         = 0;
HK1s            = 0;
RR1             = 100;
RR1s            = 0;
RR2             = 0;
RR2s            = 0;
HK1s_RR1        = 0;
HK1_RR1s        = 0;
HK1s_RR2        = 0;
HK1_RR2s        = 0;


II = logspace(0,4,20);
II2 = logspace(0,4,50);

Output_intg1 = zeros(length(II),1);
Output1 = zeros(length(II),1);
for ii = 1:length(II)
    Input = II(ii);
    IC = [HK1_unact;HK1;HK1_ATP;HK1s;RR1;RR1s;RR2;RR2s;HK1s_RR1;HK1_RR1s;HK1s_RR2;HK1_RR2s;Input];
    [t1,y1]=ode23s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase); 
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
set(gca,'linestyleorder',{'-'})
plot(II2,spline(II,Output1,II2));


%%
for kk = [10]

HK1_unact       = 10;
HK1             = 0;
HK1_ATP         = 0;
HK1s            = 0;
RR1             = 100;
RR1s            = 0;
RR2             = 100*kk;
RR2s            = 0;
HK1s_RR1        = 0;
HK1_RR1s        = 0;
HK1s_RR2        = 0;
HK1_RR2s        = 0;

IC = [HK1_unact;HK1;HK1_ATP;HK1s;RR1;RR1s;RR2;RR2s;HK1s_RR1;HK1_RR1s;HK1s_RR2;HK1_RR2s];

Output_intg2 = zeros(length(II),1);
Output2 = zeros(length(II),1);
for ii = 1:length(II)
    Input = II(ii);
    IC = [HK1_unact;HK1;HK1_ATP;HK1s;RR1;RR1s;RR2;RR2s;HK1s_RR1;HK1_RR1s;HK1s_RR2;HK1_RR2s;Input];
    [t2,y2]=ode23s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase); 
    Output_time2 = y2(:,6).^2./(K1+y2(:,6).^2)*PT;
    Output_intg2(ii) = trapz(t2,Output_time2);
%     Output2(ii) = y2(end,6).^2./(K1+y2(end,6).^2)*PT;
    Output2(ii) = max(Output_time2);
end
figure(1);
plot(II2,spline(II,Output2,II2),'y');

end
%%
figure(1)
a1 = legend({'RR_{nc} = 0','RR_{nc} = RR_c','RR_{nc} = 5RR_c','RR_{nc} = 10RR_c'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
set(gca,'xscale','log')
% set(gca,'yscale','log')
xlabel('Input signal (I_0)')
ylabel('Maximal output (O_{max})')
xlim([10^-2 10^4]);
set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,['Graphical_abstract.pdf'],'-dpdf','-r300')
