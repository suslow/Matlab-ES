close all;
while 1
    dv = input('Введите Ф.И.О.:','s'); % ввод Ф.И.О.
    % появляется приветсвенное информационное меню
    l = menu('Выберите симптомы',['' ...
        'Начать'],'Выход');
    switch l
        % при нажатии на "Начать" выбирается case 1,
        % появляется следующее меню с перечнем
        % симптомов и вариантами ответов
        case 1
            % перечисление в цикле осуществляется от 1 до количества
            % симптомов находящихся в res_Symp
            u = 1; o = 2; y = 3; c = 4; e = 5;
            for ns = 1:numel(res_Symp(:,2))
                r = menu(res_Symp(ns,2), res_LinkSympPower{u,4}, ...
                    res_LinkSympPower{o,4}, res_LinkSympPower{y,4}, ...
                    res_LinkSympPower{c,4}, res_LinkSympPower{e,4});
                
                % case 1-5 соответсвуют вариантам ответов из меню
                switch r
                    case 1
                    case 2
                    case 3
                    case 4
                    case 5
                end
                
                % создаётся матрица ps с вероятностямии соответствующие
                % выбору в ходе опроса
                for nt = 1:numel(res_Diag(:,2))
                    ps{nt,ns} = vpk{nt,ns}(1,r);
                end
                
                u = u + 5; o = o + 5; y = y + 5; c = c + 5; e = e + 5;
            end
            
            % из переменной ps типа "cell" создаётся переменная d в виде
            % матрицы типа "double" для дальнейшего использования
            for dd = 1:numel(res_Diag(:,2))
                for sd = 1:numel(res_Symp(:,2))
                    s(dd,:) = sprintf('%e ', ps{dd,:});
                    d(dd,:) = sscanf(s(dd,:), '%f')';
                end
            end
            
            % цикл для расчёта формулы Байеса
            % от 1 до количества ячеек в переменной res_Diag
            % d - матрица с набором вероятностей, p - априорная вероятность
            for k = 1:numel(res_Diag(:,2))
                % формула Байеса
                D(k) = (prod(d(k,:))*p(k))/ ...
                    ((prod(d(1,:)))*p(1)+(prod(d(2,:)))*p(2)+ ...
                    (prod(d(3,:)))*p(3)+(prod(d(4,:)))*p(4)+ ...
                    (prod(d(5,:)))*p(5));
            end
            
            % выбор номера наибольшей вероятности
            Dm = max(D); % выбор максимального значения
            md = 0;
            for rt = 1:numel(res_Diag(:,1))
                md = md + 1;
                if Dm == D(rt)
                    mdn = md;
                else
                end
            end
            
            % сравнение с пороговыми значениями элементов для вывода
            % результатов
%             for q = 1:numel(D)
%                 if D(q) <= pi(q)
%                     D(q) = 0;
%                 end
%             end
            
            % вывод результатов
            disp('Результаты:')
            for j = 1:numel(D)
                tmp = sprintf(' %s,',res_Diag{j,2});
                A = sprintf('Вероятность состояния "%s": %d', ...
                    tmp(2:end-1), D(j));
                disp(A)
            end
            
            % выбирается case 2 при нажатии "Выход"
        case 2
            break
    end
    
    % меню после прохождения опроса с возможностью начать заново или
    % завершить опрос
    t = menu('Выбор завершён','Начать заново','Выход');
    switch t
        case 1
        case 2
            if D(mdn) == 0
                break
            else
                % записывается данные в таблицу Pers и Find
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