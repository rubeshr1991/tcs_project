clear
close all

load('Fit_all_2.mat','par2')

%%

K1 = 5*10^5;
PT = 1;
Time = 20000;
% tau = 500;
% k_deg_I = 1/tau;
% Input = 100;
k_pstase = 10^-3;

%%
HK1_unact       = 10;
RR1             = 100;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1;


II = linspace(0.1,1000,20);
JJ = logspace(0,4,20);

Output_intg1 = zeros(length(II),length(JJ));
Output1 = zeros(length(II),length(JJ));

for ii = 1:length(II)
    tau = II(ii);
    k_deg_I = log(2)/tau;
    for jj = 1:length(JJ)
        Input = JJ(jj);
        IC(end) = Input;
        [t1,y1]=ode15s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase); 
        Output_time1 = y1(:,6).^2./(K1+y1(:,6).^2)*PT;
        Output_intg1(ii,jj) = trapz(t1,Output_time1);
    %     Output1(ii) = y1(end,6).^2./(K1y1(end,6).^2)*PT;
        Output1(ii,jj) = max(Output_time1);
    end
end

[X,Y] = meshgrid(II,JJ);

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(groot,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h1=figure(1);
set(h1,'position',[50 50 80*mm2pix 50*mm2pix])
hold on; box on 
surf(X,Y,Output1','Edgecolor','None')
view(2)
% set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('Input duration (\tau)')
ylabel('Input signal (I_0)')
colorbar
caxis([0,1])
% colormap gray
set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,['Omax_without_RRnc.pdf'],'-dpdf','-painters')
savefig(h1,'Omax_without_RRnc.fig');

h2=figure(2);
set(h2,'position',[50 50 80*mm2pix 50*mm2pix])
hold on; box on 
surf(X,Y,Output_intg1','Edgecolor','None')
view(2)
colorbar
caxis([min(min(Output_intg1)),max(max(Output_intg1))])
% set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('Input duration (\tau)')
ylabel('Input signal (I_0)')
set(h2,'Units','inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h2,['Otot_without_RRnc.pdf'],'-dpdf','-painters')
savefig(h2,'Otot_without_RRnc.fig');

%%
kk =5;

HK1_unact       = 10;
RR1             = 100;
RR2             = 100*kk;

IC = zeros(24,1); IC(1) = HK1_unact; IC(5) = RR1; IC(7) = RR2; 


Output_intg2 = zeros(length(II),length(JJ));
Output2 = zeros(length(II),length(JJ));

for ii = 1:length(II)
    tau = II(ii);
    k_deg_I = log(2)/tau;
    for jj = 1:length(JJ)
        Input = JJ(jj);
        IC(end) = Input;
        [t1,y1]=ode15s(@model_tcs_overall_new,[0 Time],IC,[],par2,k_deg_I,k_pstase); 
        Output_time2 = y1(:,6).^2./(K1+y1(:,6).^2)*PT;
        Output_intg2(ii,jj) = trapz(t1,Output_time2);
    %     Output1(ii) = y1(end,6).^2./(K1y1(end,6).^2)*PT;
        Output2(ii,jj) = max(Output_time2);
    end
end

h1=figure(3);
set(h1,'position',[50 50 80*mm2pix 50*mm2pix])
hold on; box on 
surf(X,Y,Output2','Edgecolor','None')
view(2)
% set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('Input duration (\tau)')
ylabel('Input signal (I_0)')
colorbar
caxis([0,1])
% colormap gray
set(h1,'Units','inches');
pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h1,['Omax_with_RRnc.pdf'],'-dpdf','-painters')
savefig(h1,'Omax_with_RRnc.fig');

h2=figure(4);
set(h2,'position',[50 50 80*mm2pix 50*mm2pix])
hold on; box on 
surf(X,Y,Output_intg2','Edgecolor','None')
view(2)
colorbar
caxis([min(min(Output_intg1)),max(max(Output_intg1))])
% set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('Input duration (\tau)')
ylabel('Input signal (I_0)')
set(h2,'Units','inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h2,['Otot_with_RRnc.pdf'],'-dpdf','-painters')
savefig(h2,'Otot_with_RRnc.fig');
