close all
clc
openfig('timevsinput_RR.fig','reuse');ax1 = gca; 
openfig('timevsoutput_RR.fig','reuse');ax2 = gca; 
openfig('I_vs_Omax.fig','reuse');ax3 = gca; 
openfig('RRnc_vs_Omax_vary_I.fig','reuse');ax4 = gca; 
openfig('tau_vs_Omax.fig','reuse');ax5 = gca; 
openfig('RRnc_vs_Omax_vary_tau.fig','reuse');ax6 = gca; 
% openfig('Omax_without_RRnc.fig','reuse');ax7 = gca; 
% openfig('Omax_with_RRnc.fig','reuse');ax8 = gca; 


set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h=figure('position',[50 50 170*mm2pix 100*mm2pix],'DefaultLegendFontSize',6,'DefaultLegendFontSizeMode','manual');
tcl=tiledlayout(2,3,'TileSpacing','tight','Padding','tight');
ax1.Parent=tcl;ax1.Layout.Tile=1;nexttile(1);legend(ax1,'show')
ax2.Parent=tcl;ax2.Layout.Tile=2;
ax3.Parent=tcl;ax3.Layout.Tile=3;
ax4.Parent=tcl;ax4.Layout.Tile=4;
ax5.Parent=tcl;ax5.Layout.Tile=5;
ax6.Parent=tcl;ax6.Layout.Tile=6;
% ax7.Parent=tcl;ax7.Layout.Tile=7;
% ax8.Parent=tcl;ax8.Layout.Tile=8;

set(h,'Units','inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h,'all_max.pdf','-dpdf')
print(h,'all_max.png','-dpng','-r300')
savefig(h,'all_max.fig')