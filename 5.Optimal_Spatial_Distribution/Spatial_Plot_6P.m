expr2 = importdata('Cells_6P_Type.txt');
data2 = expr2.data;
name2 = expr2.textdata;

xlist_all = data2(:,1); ylist_all  = data2(:,2); zlist_all = data2(:,3);
sz = 20

embryo = figure
hold on
scatter3(xlist_all,ylist_all,zlist_all,sz,data2(:,15),'filled')
axis equal;
% text(-2.8,-2.8,9,'A','FontSize',15)
% text(2.6,2.6,9,'P','FontSize',15)

view(65,20)
set(gca,'xtick',[],'xticklabel',[],'xlim',[-4,4])
set(gca,'ytick',[],'yticklabel',[],'ylim',[-4,4])
set(gca,'ztick',[5,6,7],'zticklabel',[5,6,7],'zlim',[5.5,6.5])
box on
colorbar('eastoutside')
ax = gca
load('MyColormapsE675','mycmap')
colormap(ax,mycmap)
title(['E6.75 6P Single Cells',sprintf('\n'),'Cell Type',sprintf('\n')], 'FontSize',10);
set(embryo,'position',[100 100 500 450])
hold off