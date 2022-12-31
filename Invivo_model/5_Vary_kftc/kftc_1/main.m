clear
clc
% close all
% clf

%% Parameters
load('Fit_all_2.mat','par2')
K1 = 5*10^5;
PT = 1;%%%%%%%%%%%%%%
tau = [500 1000];
k_deg_I_all = log(2)./tau;
Initial_Input_all = [100 10];
k_pstase = 0.001;
col = [0 0 0; 1 0 0];

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(groot,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;
h1=figure;
set(h1,'position',[50 50 60*mm2pix 50*mm2pix])

h2=figure;
set(h2,'position',[50 50 60*mm2pix 50*mm2pix])

for kkk = 1:2
    k_deg_I = k_deg_I_all(kkk);
    Initial_Input = Initial_Input_all(kkk);


%%
HK1_unact       = 10;
RR1             = 100;
Input           = Initial_Input;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1; IC(end) = Input;

[t1,y1]=ode23s(@model_tcs_overall_new,[0 10000],IC,[],par2,k_deg_I,k_pstase); 

figure(h1)
hold on; box on
mm(kkk) = plot(t1,y1(:,end),'color',col(kkk,:));

figure(h2)
Output1 = y1(:,6).^2./(K1+y1(:,6).^2)*PT;
hold on; box on
plot(t1,Output1,'-','color',col(kkk,:));

%%
for kk= [1]
HK1_unact       = 10;
RR1             = 100;
RR2             = 100*kk;
Input           = Initial_Input;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1; IC(7) = RR2; IC(end) = Input;

[t2,y2]=ode23s(@model_tcs_overall_new,[0 10000],IC,[],par2,k_deg_I,k_pstase);

% figure(1)
% plot(t1,y1(:,end)); hold on

figure(h2)
Output2 = y2(:,6).^2./(K1+y2(:,6).^2)*PT;
plot(t2,Output2,'--','color',col(kkk,:));
end
end

%% save
figure(h1)
hold off
a1=legend({['I_0 = ' num2str(Initial_Input_all(1)) ', \tau = ' num2str(tau(1))],...
    ['I_0 = ' num2str(Initial_Input_all(2)) ', \tau = ' num2str(tau(2))]},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
xlabel('Time (min)')
ylabel('Input (I)')
set(gca,'yscale','log')
set(gca,'xtick',[0 5000 10000])
set(gca,'ylim',[10^-4 100])

set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,'timevsinput_RR.pdf','-dpdf','-r300')
savefig(h1,'timevsinput_RR.fig')

figure(h2)
hold off
a1 = legend({'RR_{nc} = 0','RR_{nc} = RR_c','RR_{nc} = 0','RR_{nc} = RR_c'},'FontSize',7,'Location','Best');
a1.ItemTokenSize = [15,10];
xlabel('Time (min)')
ylabel('Output (O)')
% set(gca,'ylim',[0 1])
set(gca,'xtick',[0 5000 10000])

set(h2,'Units','inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h2,'timevsoutput_RR.pdf','-dpdf','-r300')
savefig(h2,'timevsoutput_RR.fig')