close all;
while 1
    dv = input('������� �.�.�.:','s'); % ���� �.�.�.
    % ���������� ������������� �������������� ����
    l = menu('�������� ��������',['' ...
        '������'],'�����');
    switch l
        % ��� ������� �� "������" ���������� case 1,
        % ���������� ��������� ���� � ��������
        % ��������� � ���������� �������
        case 1
            % ������������ � ����� �������������� �� 1 �� ����������
            % ��������� ����������� � res_Symp
            u = 1; o = 2; y = 3; c = 4; e = 5;
            for ns = 1:numel(res_Symp(:,2))
                r = menu(res_Symp(ns,2), res_LinkSympPower{u,4}, ...
                    res_LinkSympPower{o,4}, res_LinkSympPower{y,4}, ...
                    res_LinkSympPower{c,4}, res_LinkSympPower{e,4});
                
                % case 1-5 ������������ ��������� ������� �� ����
                switch r
                    case 1
                    case 2
                    case 3
                    case 4
                    case 5
                end
                
                % �������� ������� ps � �������������� ���������������
                % ������ � ���� ������
                for nt = 1:numel(res_Diag(:,2))
                    ps{nt,ns} = vpk{nt,ns}(1,r);
                end
                
                u = u + 5; o = o + 5; y = y + 5; c = c + 5; e = e + 5;
            end
            
            % �� ���������� ps ���� "cell" �������� ���������� d � ����
            % ������� ���� "double" ��� ����������� �������������
            for dd = 1:numel(res_Diag(:,2))
                for sd = 1:numel(res_Symp(:,2))
                    s(dd,:) = sprintf('%e ', ps{dd,:});
                    d(dd,:) = sscanf(s(dd,:), '%f')';
                end
            end
            
            % ���� ��� ������� ������� ������
            % �� 1 �� ���������� ����� � ���������� res_Diag
            % d - ������� � ������� ������������, p - ��������� �����������
            for k = 1:numel(res_Diag(:,2))
                % ������� ������
                D(k) = (prod(d(k,:))*p(k))/ ...
                    ((prod(d(1,:)))*p(1)+(prod(d(2,:)))*p(2)+ ...
                    (prod(d(3,:)))*p(3)+(prod(d(4,:)))*p(4)+ ...
                    (prod(d(5,:)))*p(5));
            end
            
            % ����� ������ ���������� �����������
            Dm = max(D); % ����� ������������� ��������
            md = 0;
            for rt = 1:numel(res_Diag(:,1))
                md = md + 1;
                if Dm == D(rt)
                    mdn = md;
                else
                end
            end
            
            % ��������� � ���������� ���������� ��������� ��� ������
            % �����������
%             for q = 1:numel(D)
%                 if D(q) <= pi(q)
%                     D(q) = 0;
%                 end
%             end
            
            % ����� �����������
            disp('����������:')
            for j = 1:numel(D)
                tmp = sprintf(' %s,',res_Diag{j,2});
                A = sprintf('����������� ��������� "%s": %d', ...
                    tmp(2:end-1), D(j));
                disp(A)
            end
            
            % ���������� case 2 ��� ������� "�����"
        case 2
            break
    end
    
    % ���� ����� ����������� ������ � ������������ ������ ������ ���
    % ��������� �����
    t = menu('����� ��������','������ ������','�����');
    switch t
        case 1
        case 2
            if D(mdn) == 0
                break
            else
                % ������������ ������ � ������� Pers � Find
                gtp = sprintf('ps%d', gt);
                dbfile = fullfile(pwd,'ES_DB_eng.db');
                conn = sqlite(dbfile);
                colnames = {'idPers','Name'};
                insert(conn,'Pers',colnames,{gtp,dv})
                colnames = {'idFind','idPers','idMed','idDiag','P','Date'};
                insert(conn,'Find',colnames, ...
                    {g,gtp,med,res_Diag{mdn,1},D(mdn),date})
                close(conn)
                g = g + 1;
                gt = gt + 1;
            end
            
            break
    end
end