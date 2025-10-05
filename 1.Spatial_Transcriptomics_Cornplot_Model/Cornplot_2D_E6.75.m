% E6.75 2D Corn Plot 
expr = importdata('Genes.FPKM_E6.75.txt');
data = expr.data;
name = expr.textdata;
x = [2.5,3.5,4.5,2,5,3,4,2-2/9,5+2/9,2+25/27,4+2/27,2-4/9,5+4/9,2+23/27,4+4/27,2-2/3,5+2/3,2+7/9,4+2/9,2-7/9,5+7/9,2.66,4.33,2-7/9,5+7/9,2.66,4.33,2-7/9,5+7/9,2.66,4.33];
y = [1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8];
Gene = 'T';n = 0;
for i = 1:length(name);
    if isequal(char(name(i,1)),Gene);
        n = i;
    end;
end;
c = data(n-1,:);
h = figure
scatter(x,y,400,c,'filled')
colorbar('eastoutside')
ax = gca
load('MyColormaps','mycmap')
colormap(ax,mycmap)
hold on
% delete missing position
scatter(2.5,1,400,'MarkerFaceColor','w') % 1EAP
scatter(4.5,1,400,'MarkerFaceColor','w') % 1EAP
scatter(2.5,1,400,'k') % 1EAP
scatter(4.5,1,400,'k') % 1EAP

xlabel(name(n,1),'FontSize',10)
text(2-7/9,9.1,'EA','FontSize',15,'HorizontalAlignment','center')
text(5+7/9,9.1,'EP','FontSize',15,'HorizontalAlignment','center')
text(2.66,9.1,'A','FontSize',15,'HorizontalAlignment','center')
text(4.33,9.1,'P','FontSize',15,'HorizontalAlignment','center')
set(gca,'xtick',[],'xticklabel',[],'xlim',[0.4,6.6])
set(gca,'ytick',[1,2,3,4,5,6,7,8],'yticklabel',[1,2,3,4,5,6,7,8],'ylim',[0.3,8.7],'FontSize',15)
box on
set(h,'position',[100 100 260 300])
hold off