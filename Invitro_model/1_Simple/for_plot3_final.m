clear
load('Fit_all_1.mat')

close all
% INITIAL CONDITION FOR THE ODE MODEL
HK1         = 0;
HK1s        = 700;
RR1         = par(end);
RR1s        = 0;
RR2         = par(end);
ATP         = 100000-700;
HK1_ATP     = 0;

x_init0 = [HK1, HK1s, RR1, RR1s, 0, ...
        ATP, HK1_ATP]; % initial condition

[t1,y1]=ode15s(@model_tcs3,[0 20],x_init0,[],par2);

x_init0 = [HK1, HK1s, RR1, RR1s, RR2,...
        ATP, HK1_ATP]; % initial condition

[t2,y2]=ode15s(@model_tcs3,[0 20],x_init0,[],par2); 

x_init0 = [HK1, HK1s, 0, RR1s, RR2,...
        ATP, HK1_ATP]; % initial condition

[t3,y3]=ode15s(@model_tcs3,[0 20],x_init0,[],par2); 


%%
load('Fit1_se.mat')

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h=figure('position',[50 50 60*mm2pix 50*mm2pix]);
hold on
yyaxis left
errorbar(t_data,HK1s_data_fit1,HK1s_se,'bo','MarkerSize',3)
plot(t1,(y1(:,2))/HK1s_0,'-b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HK_c')
ylim([0 1])

yyaxis right
errorbar(t_data,RR1s_data_fit1,RR1s_se,'ro','MarkerSize',3)
plot(t1,(y1(:,4))/HK1s_0,'-r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RR_c')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

set(h,'Units','inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h,'Fit1.pdf','-dpdf','-r300')
savefig(h,'Fit1.fig')

%%
load('Fit2_se.mat')
set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h=figure('position',[50 50 60*mm2pix 50*mm2pix]);
hold on
yyaxis left
errorbar(t_data,HK1s_data_fit2,HK1s_se,'bo','MarkerSize',3)
plot(t2,(y2(:,2))/HK1s_0,'-b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]+[HK_1^*RR_2]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HK_c')
ylim([0 1])

yyaxis right
errorbar(t_data,RR1s_data_fit2,RR1s_se,'ro','MarkerSize',3)
plot(t2,(y2(:,4))/HK1s_0,'-r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RR_c')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

set(h,'Units','inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h,'Fit2.pdf','-dpdf','-r300')
savefig(h,'Fit2.fig')

%%
load('Fit3_se.mat')
set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h=figure('position',[50 50 60*mm2pix 50*mm2pix]);
hold on
yyaxis left
errorbar(t_data,HK1s_data_fit3,HK1s_se,'bo','MarkerSize',3)
plot(t3,(y3(:,2))/HK1s_0,'-b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_2]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HK_c')

ylim([0 1])

yyaxis right
plot(t3,(y3(:,4))/HK1s_0,'-r');
% 
ylabel('Normalized RR_c')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

set(h,'Units','inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h,'Fit3.pdf','-dpdf','-r300')
savefig(h,'Fit3.fig')

