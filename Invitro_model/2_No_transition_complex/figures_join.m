close all
clc
openfig('Fit1.fig','reuse');ax1 = gca; pause(2)
openfig('Fit2.fig','reuse');ax2 = gca;  pause(2)
openfig('Fit3.fig','reuse');ax3 = gca;  pause(2)

set(groot,'defaultLineLineWidth',1)
set(groot,'defaultaxesfontsize',10)
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial')
mm2pix = 3.7795275591;

h=figure('position',[50 50 170*mm2pix 50*mm2pix]);
tcl=tiledlayout(1,3,'TileSpacing','tight','Padding','tight');
ax1.Parent=tcl;ax1.Layout.Tile=1; pause(2)
ax2.Parent=tcl;ax2.Layout.Tile=2; pause(2)
ax3.Parent=tcl;ax3.Layout.Tile=3; pause(2)

set(h,'Units','inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)])
print(h,'Fit_all.pdf','-dpdf')
print(h,'Fit_all.png','-dpng','-r400')
savefig(h,'Fit_all.fig')