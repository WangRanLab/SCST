% Spatial smoothing E6.75

expr1 = importdata('Position_Coordinates_E6.75.txt');
data1 = expr1.data;
name1 = expr1.textdata;

[cell Germlayer top1 top2 top3 srcc1 srcc2 srcc3] = textread('E6.75_Top3.Position+SRCC.txt','%s%s%s%s%s%f%f%f','headerlines',1);

cell_location = {};
for m = 1:length(cell)
    if length(find('Ect'==Germlayer{m})) == 3
        P1 = find(ismember(name1(1,2:16),top1(m)));
        P2 = find(ismember(name1(1,2:16),top2(m)));
        P3 = find(ismember(name1(1,2:16),top3(m)));
        x=[data1(1,P1),data1(1,P2),data1(1,P3)];
        y=[data1(2,P1),data1(2,P2),data1(2,P3)];
        z=[data1(3,P1),data1(3,P2),data1(3,P3)];
        wt = [srcc1(m),srcc2(m),srcc3(m)];
        dist=@(var) sum(wt.*(sqrt((var(1)-x).^2+(var(2)-y).^2+(var(3)-z).^2)));%var(1)=x;var(2)=y;var(3)=z;
        var0=rand(3,1);
        [var,minDistance,exitflag]=fminunc(dist,var0);
        dist = [];
        for i = 1:length(data1(1,2:16))
            dist(end+1) = norm([var(1) var(2) var(3)] - [data1(1,i) data1(2,i) data1(3,i)]);
        end
        minposition = find(dist == min(dist)); % find the position with the minimum distance
        name1(1,minposition+1); % the position name
        cell_location = [cell_location,name1(1,minposition+1)];
    end
    if length(find('End'==Germlayer{m})) == 3
        P1 = find(ismember(name1(1,17:31),top1(m))) + 15;
        P2 = find(ismember(name1(1,17:31),top2(m))) + 15;
        P3 = find(ismember(name1(1,17:31),top3(m))) + 15;
        x=[data1(1,P1),data1(1,P2),data1(1,P3)];
        y=[data1(2,P1),data1(2,P2),data1(2,P3)];
        z=[data1(3,P1),data1(3,P2),data1(3,P3)];
        wt = [srcc1(m),srcc2(m),srcc3(m)];
        dist=@(var) sum(wt.*(sqrt((var(1)-x).^2+(var(2)-y).^2+(var(3)-z).^2)));%var(1)=x;var(2)=y;var(3)=z;
        var0=rand(3,1);
        [var,minDistance,exitflag]=fminunc(dist,var0);
        dist = [];
        for i = 16:30 % the position of endoderm
            dist(end+1) = norm([var(1) var(2) var(3)] - [data1(1,i) data1(2,i) data1(3,i)]);
        end
        minposition = find(dist == min(dist)); % find the position with the minimum distance
        name1(1,minposition+15+1); % the position name
        cell_location = [cell_location,name1(1,minposition+15+1)];
    end
    
end

fid = fopen('Location_E6.75.SCs.txt','w');
for i = 1:length(cell_location)
fprintf(fid,'%s\r\n',cell_location{i});
end
fclose(fid)