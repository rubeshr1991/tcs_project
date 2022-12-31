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
set(groot,'defaultaxesfontsize',12)

h=figure('position',[50 50 600 500]);
hold on
yyaxis left
errorbar(t_data,HK1s_data_fit1,HK1s_se,'bo','MarkerSize',7)
plot(t1,(y1(:,2)+y1(:,7)+y1(:,9))/HK1s_0,'b');
plot(t1,(y1(:,8))/HK1s_0,'b--');
xlabel('Time (min)')
% ylabel('$$\frac{[HK_1^*]+[HK_1^*RR_1]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized HK_1')
ylim([0 1])

yyaxis right
errorbar(t_data,RR1s_data_fit1,RR1s_se,'ro','MarkerSize',7)
plot(t1,(y1(:,4))/HK1s_0,'r');

% ylabel('$$\frac{[RR_1^*]}{\phi_{HK} [HK_1]_0}$$','interpreter','latex')
ylabel('Normalized RR_1')
ylim([0 1])
plt = gca;
plt.YAxis(1).Color = 'b';
plt.YAxis(2).Color = 'r';


