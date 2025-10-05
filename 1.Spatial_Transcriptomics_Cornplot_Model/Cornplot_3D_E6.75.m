% E6.75 3D Corn Plot Epiblast + Endoderm
% Epiblast
expr1 = importdata('E6.75_Epi_3D.txt');
data1 = expr1.data;
name1 = expr1.textdata;

x1 = [0,-1,1,-13/9,13/9,-16/9,16/9,-17/9,17/9,-2,2,-2,2,-2,2];
y1 = [0,-1,1,-13/9,13/9,-16/9,16/9,-17/9,17/9,-2,2,-2,2,-2,2];
z1 = [1,2,2,3,3,4,4,5,5,6,6,7,7,8,8];

Gene = 'T';n = 0;
for i = 1:length(name1);
    if isequal(char(name1(i,1)),Gene);
        n = i;
    end;
end;

c = data1(n-1,:);
epiblast = figure
scatter3(x1,y1,z1,300,c,'filled')
view(65,15)
colorbar('eastoutside')
ax = gca
load('MyColormaps','mycmap')
colormap(ax,mycmap)
hold on
xlabel(name1(n,1),'FontSize',15)
text(-2.2,-2.2,9.2,'A','FontSize',15)
text(1.8,1.8,9.2,'P','FontSize',15)

set(gca,'xtick',[],'xticklabel',[],'xlim',[-4,4])
set(gca,'ytick',[],'yticklabel',[],'ylim',[-4,4])
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.3,8.7],'FontSize',15)
box on
set(epiblast,'position',[100 100 510 380])
hold off

% Endoderm
expr3 = importdata('E6.75_End_3D.txt');
data3 = expr3.data;
name3 = expr3.textdata;

x3 = [-1.4,1.4,-2,2,-22/9,22/9,-25/9,25/9,-26/9,26/9,-3,3,-3,3,-3,3];
y3 = [-1.4,1.4,-2,2,-22/9,22/9,-25/9,25/9,-26/9,26/9,-3,3,-3,3,-3,3];
z3 = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8];

c = data3(n-1,:);
endoderm = figure
scatter3(x3,y3,z3,300,c,'filled')
view(65,15)
colorbar('eastoutside')
ax = gca
load('MyColormaps','mycmap')
colormap(ax,mycmap)
hold on

% delete missing position
scatter3(-1.4,-1.4,1,300,'MarkerFaceColor','w') % 1EA
scatter3(1.4,1.4,1,300,'MarkerFaceColor','w') % 1EP
scatter3(-1.4,-1.4,1,300,'k') % 1EA
scatter3(1.4,1.4,1,300,'k') % 1EP

xlabel(name3(n,1),'FontSize',15)
text(-3.25,-3.25,9.2,'EA','FontSize',15)
text(2.75,2.75,9.2,'EP','FontSize',15)

set(gca,'xtick',[],'xticklabel',[],'xlim',[-4,4])
set(gca,'ytick',[],'yticklabel',[],'ylim',[-4,4])
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.3,8.7],'FontSize',15)
box on
set(endoderm,'position',[100 100 510 380])
hold off
