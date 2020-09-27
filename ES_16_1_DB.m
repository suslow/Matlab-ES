clear all
% создаётся соединение между файлом базы данных
dbfile = 'ES_DB1.db';
conn = sqlite(dbfile);

% используется SELECT * FROM и присваиваются переменные
sqlq_Diag2 = 'SELECT * FROM Diag2';
% fetch для представления в табличном виде
res_Diag2 = fetch(conn,sqlq_Diag2);

sqlq_Symp2 = 'SELECT * FROM Symp2';
res_Symp2 = fetch(conn,sqlq_Symp2);

sqlq_Power2 = 'SELECT * FROM Power2';
res_Power2 = fetch(conn,sqlq_Power2);

sqlq_LinkSympPower2 = 'SELECT * FROM LinkSympPower2';
res_LinkSympPower2 = fetch(conn,sqlq_LinkSympPower2);

sqlq_LinkDiagSymp2 = 'SELECT * FROM LinkDiagSymp2';
res_LinkDiagSymp2 = fetch(conn,sqlq_LinkDiagSymp2);


% создаются новые переменные для дальнейшего использования
Symp = res_Symp2(:,2);

Diag = res_Diag2(:,2)';

% априорная вероятность
pc = res_Diag2(:,3)';
m = sprintf('%e ', pc{:});
p = sscanf(m, '%f');

vpk{1,1} = [res_LinkDiagSymp2{1:4,4}];
vpk{1,2} = [res_LinkDiagSymp2{5:8,4}];
vpk{1,3} = [res_LinkDiagSymp2{9:12,4}];
vpk{2,3} = [res_LinkDiagSymp2{13:16,4}];
vpk{2,4} = [res_LinkDiagSymp2{17:20,4}];
vpk{2,5} = [res_LinkDiagSymp2{21:24,4}];
vpk{2,6} = [res_LinkDiagSymp2{25:28,4}];
vpk{2,7} = [res_LinkDiagSymp2{29:32,4}];

hj = [(1:3),(4:5),(6:8)];

% vpk01 = [{vpk1,{vpk2},{vpk3}];
% vpk02 = [{vpk4},{vpk5},{vpk6},{vpk7},{vpk8}];
% vpk = [{vpk01};{vpk02}];

% vpk = [vpk1;vpk2;vpk3;vpk4;vpk5;vpk6;vpk7;vpk8];

% yt = 1; bn = 1; gh = 1;
% for lds = 1:numel(res_LinkDiagSymp{1:32,1})
%     ds{lds,bn} = res_LinkDiagSymp{lds,4};
%     gh = gh + 3;
%     if gh == yt
%         bn = bn + 1;
%     end
%     yt = yt + 3;
% end

% gr = [1,2,3];
% ga = [3,4];
% di = [5,6,7];

% grv = [1,2,3];
% gav = [4,5];
% div = [6,7,8];
% 
% [h1v] = grv;
% [h2v] = gav;
% [h3v] = div;
% hov = {h1v, h2v, h3v};
hov = [{1:3},{4:5},{6:8}];

% [h1] = gr;
% [h2] = ga;
% [h3] = di;
% ho = {h1, h2, h3};
ho = [{1:3},{3:4},{5:7}];

% пороговые значения
Dk(1) = 0.45;
Dk(2) = 0.45;
Dk(3) = 0.45;
Dk(4) = 0.45;

% закрывается соединение
close(conn)
g = 1;