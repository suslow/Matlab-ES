clear all
% �������� ���������� ����� ������ ���� ������
dbfile = 'ES_DB_eng.db';
conn = sqlite(dbfile);

% ������������ SELECT * FROM � ������������� ����������
sqlq_Diag = 'SELECT * FROM Diag';
% fetch ��� ������������� � ��������� ����
res_Diag = fetch(conn,sqlq_Diag);

sqlq_Symp = 'SELECT * FROM Symp';
res_Symp = fetch(conn,sqlq_Symp);

sqlq_Power = 'SELECT * FROM Power';
res_Power = fetch(conn,sqlq_Power);

sqlq_LinkSympPower = 'SELECT * FROM LinkSympPower';
res_LinkSympPower = fetch(conn,sqlq_LinkSympPower);

sqlq_LinkDiagSympPower = 'SELECT * FROM LinkDiagSympPower';
res_LinkDiagSympPower = fetch(conn,sqlq_LinkDiagSympPower);

sqlq_DiagDop = 'SELECT * FROM DiagDop';
res_DiagDop = fetch(conn,sqlq_DiagDop);

% ��������� �����������
% ���������� ��� ���������� � cell �� double � ������������� ���������� p
pc = res_DiagDop(:,3)';
pm = sprintf('%e ', pc{:});
p = sscanf(pm, '%f');

% ��������� ��������
% ���������� ��� ���������� � cell �� double � ������������� ���������� dk
dc = res_Diag(:,3)';
dm = sprintf('%e ', dc{:});
pi = sscanf(dm, '%f');

% �������� ������� �� ��������� ������� ���������� res_LinkDiagSympPower
a = 1; ab = 5; e = 1;
for w = 1:numel(res_Diag(:,2))
    for z = 1:numel(res_Symp(:,2))
        vpk{w,z} = [res_LinkDiagSympPower{a:ab,4}];
        a = a + 5; ab = ab + 5;
    end
end

% ����������� ����������
close(conn)
g = 1; gt = 1; med = 0;