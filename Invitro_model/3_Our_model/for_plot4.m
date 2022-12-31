clear
load('Fit_all_2.mat')

close all
% INITIAL CONDITION FOR THE ODE MODEL
HK1         = 0;
HK1s        = 700;
RR1         = par2(end);
RR1s        = 0;
RR2         = par2(end);
RR2s        = 0;
HK1sRR1     = 0;
HK1RR1s     = 0;
HK1sRR2     = 0;
HK1RR2s     = 0;
ATP         = 0;
HK1_ATP     = 0;
iP          = 0;

x_init0 = [HK1, HK1s, RR1, RR1s, 0, RR2s, HK1sRR1, HK1RR1s, HK1sRR2, HK1RR2s,...
    ATP, HK1_ATP, iP]; % initial condition

[t1,y1]=ode15s(@model_tcs3,[0 20],x_init0,[],par2);  

x_init0 = [HK1, HK1s, RR1, RR1s, RR2, RR2s, HK1sRR1, HK1RR1s, HK1sRR2, HK1RR2s,...
    ATP, HK1_ATP, iP]; % initial condition

[t2,y2]=ode15s(@model_tcs3,[0 20],x_init0,[],par2); 

x_init0 = [HK1, HK1s, 0, RR1s, RR2, RR2s, HK1sRR1, HK1RR1s, HK1sRR2, HK1RR2s,...
    ATP, HK1_ATP, iP]; % initial condition

[t3,y3]=ode15s(@model_tcs3,[0 20],x_init0,[],par2); 



%%
load('Fit1_se.mat')

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')

[~,pos1] = tight_subplot(1,3,[.15 .12],[.18 .04],[.05 .05]);close all;

h1 = figure;
set(h1,'Units','centimeters');
set(h1,'position',[1,3,18,5])

axes(axes('Units','normalized','Position',pos1{1}))
hold on
yyaxis left
errorbar(t_data,HK1s_data_fit1,HK1s_se,'bo','MarkerSize',3)
plot(t1,(y1(:,2)+y1(:,7)+y1(:,9))/HK1s_0,'b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HKc')
ylim([0 1])

yyaxis right
errorbar(t_data,RR1s_data_fit1,RR1s_se,'ro','MarkerSize',3)
plot(t1,(y1(:,4))/HK1s_0,'r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RRc')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

%%
load('Fit2_se.mat')

axes(axes('Units','normalized','Position',pos1{2}))
hold on
yyaxis left
errorbar(t_data,HK1s_data_fit2,HK1s_se,'bo','MarkerSize',3)
plot(t2,(y2(:,2)+y2(:,7)+y2(:,9))/HK1s_0,'b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]+[HK_1^*RR_2]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HKc')
ylim([0 1])

yyaxis right
errorbar(t_data,RR1s_data_fit2,RR1s_se,'ro','MarkerSize',3)
plot(t2,(y2(:,4))/HK1s_0,'r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RRc')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';


%%
load('Fit3_se.mat')

axes(axes('Units','normalized','Position',pos1{3}))

hold on
yyaxis left
errorbar(t_data,HK1s_data_fit3,HK1s_se,'bo','MarkerSize',3)
plot(t3,(y3(:,2)+y3(:,7)+y3(:,9))/HK1s_0,'b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_2]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HKc')

ylim([0 1])

yyaxis right
plot(t3,(y3(:,4))/HK1s_0,'r');
% 
ylabel('Normalized RRc')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
print(h1,'Fit_123.pdf','-dpdf','-r300')

%%
% load('PdtaR-RFP_data_new.mat')
% load('PdtaR-RFP_se.mat')
load('Fit1_se.mat')

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')

h = figure;
set(h,'Units','centimeters');
set(h,'position',[1,3,6,5])
hold on
% yyaxis left
% errorbar(t_data,HK1s_data_fit1,HK1s_se,'bo','MarkerSize',3)
% yyaxis right
% errorbar(t_data,RR1s_data_fit1,RR1s_se,'ro','MarkerSize',3)
load('PdtaR-RFP_data_new.mat')
load('PdtaR-RFP_se.mat')
yyaxis left
errorbar(t_data,HK1s_data,HK1s_se,'b^','MarkerSize',3)
plot(t1,(y1(:,2)+y1(:,7)+y1(:,9))/HK1s_0,'b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]+[HK_1^*RR_3]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HKc')
ylim([0 1])
yyaxis right
errorbar(t_data,RR1s_data,RR1s_se,'r^','MarkerSize',3)
plot(t1,(y1(:,4))/HK1s_0,'r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RRc')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
print(h,'Fit_PdtaR.pdf','-dpdf','-r300')

%%
% load('PdtaR-RFP_data_new.mat')
% load('PdtaR-RFP_se.mat')
load('Fit1_se.mat')

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')

h = figure;
set(h,'Units','centimeters');
set(h,'position',[1,3,6,5])

hold on
yyaxis left
plot(t_data,HK1s_data_fit1,'bo','MarkerSize',3)
yyaxis right
plot(t_data,RR1s_data_fit1,'ro','MarkerSize',3)
load('PdtaR-RFP_data_new.mat')
load('PdtaR-RFP_se.mat')
yyaxis left
plot(t_data,HK1s_data,'b^','MarkerSize',3)
plot(t1,(y1(:,2)+y1(:,7)+y1(:,9))/HK1s_0,'b');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]+[HK_1^*RR_3]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HKc')
ylim([0 1])
yyaxis right
plot(t_data,RR1s_data,'r^','MarkerSize',3)
plot(t1,(y1(:,4))/HK1s_0,'r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RRc')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';

pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
print(h,'Fit_PdtaR_no_errbar.pdf','-dpdf','-r300')
