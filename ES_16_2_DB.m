close all;
while 1
    dv = input('������� �.�.�.:','s'); % ���� �.�.�.
    % ���������� ������������� �������������� ����
    l = menu('�������� ��������',['' ...
        '������'],'�����');
    switch l
        % ��� ������� �� "������" ���������� case 1, ���������� ��������� ���� � ��������
        % ��������� � ���������� �������
        case 1
            % ������������ � ����� �������������� �� 1 �� ����������
            % ��������� ����������� � Symp
            u = 1; o = 2; y = 3; c = 4; m = 1;
            cf = cellfun(@isempty,vpk);
            for ns = 1:numel(Symp)
                r = menu(Symp(ns), res_LinkSympPower2{u,4}, res_LinkSympPower2{o,4}, res_LinkSympPower2{y,4}, res_LinkSympPower2{c,4});
                cfc = cf(:,ns);
                % case 1-2 ������������ ��������� ������� �� ����
                switch r
                    case 1
                        t = 1;
                        ps{m,ns} = vpk{m,ns}(1,t);
                    case 2
                        t = 2;
                        ps{m,ns} = vpk{m,ns}(1,t);
                    case 3
                        t = 3;
                        ps{m,ns} = vpk{m,ns}(1,t);
                    case 4
                        t = 4;
                        ps{m,ns} = vpk{m,ns}(1,t);
                end
                
                if cfc == 0
                    m = m + 1;
                    ps{m,ns} = vpk{m,ns}(1,t);
                else
                end
                
                u = u + 4; o = o + 4; y = y + 4; c = c + 4;
            end
            % �� ���������� ps ���� "cell" �������� ���������� pss � ����
            % ������� ���� "double" ��� ����������� �������������

            s = sprintf('%e ', ps{:});
            d = sscanf(s, '%f')';
            
            % ���� ��� ������� ������� ������
            n = 1; b = 1; x = 1;
            for k = 1:numel(hov) % �� 1 �� ���������� ����� � ���������� hov
                i = hov{1,k};

%             for k = 1:numel(Diag) % �� 1 �� ���������� ����� � ���������� Diag
                % ������� ������
                D(n) = prod(d(i))*p(n,1)/((prod(d(1:3))*p(1,1))+(prod(d(4:5))*p(2,1))+(prod(d(6:8))*p(3,1)));%+(1-prod(d(i))*p(n,1)));
%                 k = k + 1;
                n = n + 1;
            end
            
%             % ��������� � ���������� ����������
            for q = 1:numel(D)
                if D(q) <= Dk(q)
                    D(q) = 0;
                end
            end
            
            % ����� �����������
            disp('����������:')
            for j = 1:numel(D)
                tmp = sprintf(' %s,',Diag{1,j});
                A = sprintf('����������� ��������� "%s": %d', tmp(2:end-1), D(j));
                disp(A)
            end
            
            % ���������� case 2 ��� ������� "�����"
        case 2
            break
    end
    
    
%     % ���� ����� ����������� ������ � ������������ ������ ������ ���
%     % ��������� �����
    t = menu('����� ��������','������ ������','�����');
    switch t
        case 1
        case 2
            % ������������ ������ � ������� Find
            for f = 1:numel(D)
                dbfile = fullfile(pwd,'ES_DB1.db');
                conn = sqlite(dbfile);
                % createFind = ['create table Find ' ...
                % '(idFind NUMERIC, idPers NUMERIC, ' ...
                % 'idDiag NUMERIC, P NUMERIC, Date VARCHAR)'];
                % exec(conn,createFind)
                
                colnames = {'idFind','idPers','idDiag','P','Date'};
                
                insert(conn,'Find2',colnames, ...
                    {g,dv,Diag{1,f},D(f),date})
                
                close(conn)
                g = g + 1;
            end
            
            break
    end
end