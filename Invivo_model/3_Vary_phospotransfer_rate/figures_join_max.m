close all
clc
openfig('I_vs_Omax.fig','reuse');ax1 = gca; set(gca,'YLabel',[]);
openfig('I_vs_Omax_ptransfer.fig','reuse');ax2 = gca; set(gca,'YLabel',[]);
openfig('I_vs_Omax_nofb.fig','reuse');ax3 = gca; set(gca,'YLabel',[]);

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h=figure('position',[50 50 170*mm2pix 50*mm2pix],'DefaultLegendFontSize',6,'DefaultLegendFontSizeMode','manual');
tcl=tiledlayout(1,3,'TileSpacing','tight','Padding','tight');
ax1.Parent=tcl;ax1.Layout.Tile=1;
text(-0.15, 1, 'A', 'Units', 'normalized', 'VerticalAlignment','Bottom', 'FontWeight','bold');
    
ax2.Parent=tcl;ax2.Layout.Tile=2;
text(1.05, 1, 'B', 'Units', 'normalized', 'VerticalAlignment','Bottom', 'FontWeight','bold');
    
ax3.Parent=tcl;ax3.Layout.Tile=3;
text(2.2, 1, 'C', 'Units', 'normalized', 'VerticalAlignment','Bottom', 'FontWeight','bold');
    
ylabel(tcl,'Maximal output (O_{max})');
set(h,'Units','inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h,'all_max.pdf','-dpdf')
print(h,'all_max.png','-dpng','-r300')
savefig(h,'all_max.fig')