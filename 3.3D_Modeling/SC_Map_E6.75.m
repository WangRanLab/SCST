% ===================================================================
% 3D modelling for the E6.75 embryo
% ===================================================================

position_epi = {'1A','1P','2A','2P','3A','3P','4A','4P','5A','5P','6A','6P','7A','7P','8A','8P'};
position_end = {'1EAP','1EAP','2EA','2EP','3EA','3EP','4EA','4EP','5EA','5EP','6EA','6EP','7EA','7EP','8EA','8EP'};

expr1 = importdata('Cell_Info_E6.75.txt');
data1 = expr1.data;
name1 = expr1.textdata;
c1 = data1(:,1);c2 = data1(:,2);c3 = data1(:,3);c4 = data1(:,4);c5 = data1(:,5);c6 = data1(:,6);
c7 = data1(:,7);c8 = data1(:,8);c9 = data1(:,9);c10 = data1(:,10);c11 = data1(:,11);c12 = data1(:,12);
sz = 5;

xlist_epi = []; ylist_epi = []; zlist_epi = []; color_epi = []; cell_epi = {};

Epi = figure
hold on
x_cd = [2,3,1.8,3.2,1.6,3.4,1.4,3.6,1.3,3.7,1.2,3.8,1.1,3.9,1,4];
y_cd = [2,3,1.8,3.2,1.6,3.4,1.4,3.6,1.3,3.7,1.2,3.8,1.1,3.9,1,4];
z_cd = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8];
for i = 1:length(x_cd)
    if rem(i,2) == 1
       for j = 1:length(data1)
            if strcmp(name1(j+1,3),position_epi(i));
                cnt = 0;
                while cnt < 1
                    x = 10*rand()-5;
                    y = 10*rand()-5;
                    if ((x-0)^2 + (y-0)^2 < (norm([x_cd(i) y_cd(i)]-[x_cd(i+1) y_cd(i+1)]))^2 && y < -x);% Determine whether the cell is inside the circle.
                        cnt = cnt + 1;
                    end
                end
                z = rand() + z_cd(i) - 0.5;
                scatter3(x,y,z,sz,c1(j),'filled');
                xlist_epi(end+1) = x; ylist_epi(end+1) = y; zlist_epi(end+1) = z; color_epi(end+1) = c1(j); cell_epi = [cell_epi,name1(j+1,1)];
            end
        end
    end
    
    if rem(i,2) == 0
        for j = 1:length(data1)
            if strcmp(name1(j+1,3),position_epi(i));
                cnt = 0;
                while cnt < 1
                    x = 10*rand()-5;
                    y = 10*rand()-5;
                    if ((x-0)^2 + (y-0)^2 < (norm([x_cd(i-1) y_cd(i-1)]-[x_cd(i) y_cd(i)]))^2 && y > -x); %  Determine whether the cell is inside the circle.
                        cnt = cnt + 1;
                    end
                end
                z = rand() + z_cd(i) - 0.5;
                scatter3(x,y,z,sz,c1(j),'filled');
                xlist_epi(end+1) = x; ylist_epi(end+1) = y; zlist_epi(end+1) = z; color_epi(end+1) = c1(j); cell_epi = [cell_epi,name1(j+1,1)];
            end
        end
    end
end
axis equal;
% xlabel('T','FontSize',12)
text(-3.3,-3.3,9,'A','FontSize',15)
text(3,3,9,'P','FontSize',15)
view(65,20)
set(gca,'xtick',[],'xticklabel',[],'xlim',[-5,5]) % Unify the scale
set(gca,'ytick',[],'yticklabel',[],'ylim',[-5,5])
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.2,8.8])
box on
colorbar('eastoutside')
ax = gca
load('MyColormapsRedGray','mycmap')
colormap(ax,mycmap)
title(['Epiblast Single Cells',sprintf('\n'),'Gene T expression',sprintf('\n')]);
set(Epi,'position',[100 100 500 500])
hold off

% ======================================================================
% End
xlist_end = []; ylist_end = []; zlist_end = []; color_end = []; cell_end = {};
End = figure
hold on
x_cd = [-0.8,0.8,-1,1,-1.2,1.2,-1.4,1.4,-1.5,1.5,-1.6,1.6,-1.7,1.7,-1.8,1.8];
y_cd = [-0.8,0.8,-1,1,-1.2,1.2,-1.4,1.4,-1.5,1.5,-1.6,1.6,-1.7,1.7,-1.8,1.8];
z_cd = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8];
for i = 1:length(x_cd)
    if rem(i,2) == 1
        for j = 1:length(data1)
            if strcmp(name1(j+1,3),position_end(i));
                cnt = 0;
                while cnt < 1
                    x = 12*rand()-6;
                    y = 12*rand()-6;
                    if ((x-0)^2 + (y-0)^2 < (norm([x_cd(i) y_cd(i)]-[x_cd(i+1) y_cd(i+1)]))^2 && (x-0)^2 + (y-0)^2 > (norm([x_cd(i)+0.1 y_cd(i)+0.1]-[x_cd(i+1)-0.1 y_cd(i+1)-0.1]))^2 && y < -x);%  Determine whether the cell is inside the circle.
                        cnt = cnt + 1;
                    end
                end
                z = rand() + z_cd(i) - 0.5;
                scatter3(x,y,z,sz,c1(j),'filled');
                xlist_end(end+1) = x; ylist_end(end+1) = y; zlist_end(end+1) = z; color_end(end+1) = c1(j); cell_end = [cell_end,name1(j+1,1)];
            end
        end
    end
    
    if rem(i,2) == 0
        for j = 1:length(data1)
            if strcmp(name1(j+1,3),position_end(i));
                cnt = 0;
                while cnt < 1
                    x = 12*rand()-6;
                    y = 12*rand()-6;
                    if ((x-0)^2 + (y-0)^2 < (norm([x_cd(i-1) y_cd(i-1)]-[x_cd(i) y_cd(i)]))^2 && (x-0)^2 + (y-0)^2 > (norm([x_cd(i-1)+0.1 y_cd(i-1)+0.1]-[x_cd(i)-0.1 y_cd(i)-0.1]))^2 && y > -x);%  Determine whether the cell is inside the circle.
                        cnt = cnt + 1;
                    end
                end
                z = rand() + z_cd(i) - 0.5;
                scatter3(x,y,z,sz,c1(j),'filled');
                xlist_end(end+1) = x; ylist_end(end+1) = y; zlist_end(end+1) = z; color_end(end+1) = c1(j); cell_end = [cell_end,name1(j+1,1)];
            end
        end
    end
end
axis equal;
% xlabel('T','FontSize',12)
text(-4.1,-4.1,10,'EA','FontSize',15)
text(3.6,3.6,10,'EP','FontSize',15)
view(65,20)
set(gca,'xtick',[],'xticklabel',[],'xlim',[-5,5])
set(gca,'ytick',[],'yticklabel',[],'ylim',[-5,5])
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.2,8.8])
box on
colorbar('eastoutside')
ax = gca
load('MyColormapsRedGray','mycmap')
colormap(ax,mycmap)
title(['Endoderm Single Cells',sprintf('\n'),'Gene T expression',sprintf('\n')]);
set(End,'position',[100 100 500 500])
hold off

xlist_all = [xlist_epi xlist_end];
ylist_all = [ylist_epi ylist_end];
zlist_all = [zlist_epi zlist_end];
color_all = [color_epi color_end];
cell_all = [cell_epi cell_end];

fid = fopen('Spatial_Coordinates_E6.75.txt','w');
for i = 1:length(cell_all)
fprintf(fid,'%s \t',cell_all{i});
end
fprintf(fid,'\r\n');  % \n
fprintf(fid,'%d \t ',xlist_all);
fprintf(fid,'\r\n');  % \n
fprintf(fid,'%d \t ',ylist_all);
fprintf(fid,'\r\n');  % \n
fprintf(fid,'%d \t ',zlist_all);
fprintf(fid,'\r\n');  % \n
fclose(fid);

% ===================================================
% Single-cell map: Cell type
% ===================================================

expr2 = importdata('Cell_Info_E6.75+3D.Coordinates.txt');
data2 = expr2.data;
name2 = expr2.textdata;
sz = 10;

xlist_all = data2(:,1); ylist_all  = data2(:,2); zlist_all = data2(:,3);

embryo = figure;
hold on;
scatter3(xlist_all,ylist_all,zlist_all,sz,data2(:,15),'filled');
text(-2.8,-2.8,9,'A','FontSize',15);
text(2.6,2.6,9,'P','FontSize',15);
% text(-4.3,-4.3,10,'EA','FontSize',15);
% text(3.6,3.6,10,'EP','FontSize',15);
view(65,20);
set(gca,'xtick',[],'xticklabel',[],'xlim',[-5,5]);
set(gca,'ytick',[],'yticklabel',[],'ylim',[-5,5]);
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.2,8.8]);
box on;
colorbar('eastoutside');
ax = gca;
load('MyColormapsE675','mycmap');
colormap(ax,mycmap);
title(['E6.75 All Single Cells',sprintf('\n'),'Cell Type',sprintf('\n')]);
set(embryo,'position',[100 100 500 450]);
%axis equal;
hold off;

% save the colorbar
ax = gca;
mycmap = colormap(ax); 
save('MyColormapsE675','mycmap');

xlist_epi = data2(1:1367,1);ylist_epi = data2(1:1367,2);zlist_epi = data2(1:1367,3);
xlist_ve = data2(1368:1475,1);ylist_ve = data2(1368:1475,2);zlist_ve = data2(1368:1475,3);

% Epi

embryo = figure
hold on
scatter3(xlist_epi,ylist_epi,zlist_epi,sz,data2(1:1367,15),'filled')
text(-2.8,-2.8,9,'A','FontSize',15)
text(2.6,2.6,9,'P','FontSize',15)

% text(-4.3,-4.3,10,'EA','FontSize',15)
% text(3.6,3.6,10,'EP','FontSize',15)
view(65,20)
set(gca,'xtick',[],'xticklabel',[],'xlim',[-5.1,5.1])
set(gca,'ytick',[],'yticklabel',[],'ylim',[-5.1,5.1])
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.2,8.8])
box on
colorbar('eastoutside')
ax = gca
load('MyColormapsE675','mycmap')
colormap(ax,mycmap)
title(['E6.75 Epi Single Cells',sprintf('\n'),'Cell Type',sprintf('\n')], 'FontSize',12);
set(embryo,'position',[100 100 500 450])
%axis equal;
hold off

% Endoderm
embryo = figure
hold on
scatter3(xlist_ve,ylist_ve,zlist_ve,sz,data2(1368:1475,15),'filled')
text(-2.8,-2.8,9,'EA','FontSize',15)
text(2.6,2.6,9,'EP','FontSize',15)

view(65,20)
set(gca,'xtick',[],'xticklabel',[],'xlim',[-5.1,5.1])
set(gca,'ytick',[],'yticklabel',[],'ylim',[-5.1,5.1])
set(gca,'ztick',[1,2,3,4,5,6,7,8],'zticklabel',[1,2,3,4,5,6,7,8],'zlim',[0.2,8.8])
box on
colorbar('eastoutside')
ax = gca
load('MyColormapsE675','mycmap')
colormap(ax,mycmap)
title(['E6.75 Endoderm Single Cells',sprintf('\n'),'Cell Type',sprintf('\n')], 'FontSize',12);
set(embryo,'position',[100 100 500 450])
%axis equal;
hold off