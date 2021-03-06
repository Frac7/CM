%% PRIMA PARTE 
% verifica con sistemi casuali della bontà del metodo QR, con
% fattorizzazione QR di Householder e Givens e confronto con metodologie
% MATLAB
%%
addpath Functions/

m = 20;
n = 10;
times = 20;

%% Creazione vettori appoggio

arrayIndex = 1:times;
dimRow = ones(1,times);
dimColumn = ones(1,times);

errorSolm = ones(1,times);
errorSolh = ones(1,times);
errorSolg = ones(1,times);

errorSolOriginalm = ones(1,times);
errorSolOriginalh = ones(1,times);
errorSolOriginalg = ones(1,times);

tm = ones(1,times);
th = ones(1,times);
tg = ones(1,times);

errorQRm = ones(1,times);
errorQRh = ones(1,times);
errorQRg = ones(1,times);

errorQm = ones(1,times);
errorQh = ones(1,times);
errorQg = ones(1,times);

for i=1:times
    %generazione dati casuali
    A = rand(m, n);
    x = rand(n,1);
    b = A * x;

    %primo esperimento con Matlab
    [errorSolm(i), tm(i), errorQRm(i), errorQm(i), errorSolOriginalm(i)] = ComputeErrors(@qr, A, x, b);
    
    %secondo esperimento con fattorizzazione Householder
    [errorSolh(i), th(i), errorQRh(i), errorQh(i), errorSolOriginalh(i)] = ComputeErrors(@HouseHolderQR, A, x, b);

    %terzo esperimento con fattorizzazione Givens
    [errorSolg(i), tg(i), errorQRg(i), errorQg(i), errorSolOriginalg(i)] = ComputeErrors(@GivensQR, A, x, b);

    m = m + 10;
    n = n + 10;
    
    dimRow(i) = m;
    dimColumn(i) = n;
end

dimensionByStep = table (dimRow, dimColumn);

clear dimRow dimColumn

%% stampa dei grafici

figure
%subplot(3, 2, 1)
%plot(arrayIndex, errorSolm, '--o',  arrayIndex, errorSolh, '--o', arrayIndex, errorSolg, '--o');
semilogy(arrayIndex, errorSolm, '--o',  arrayIndex, errorSolh, '--o', arrayIndex, errorSolg, '--o');
title('Relative Residue part1');
xlabel('Step');
ylabel('Error');
legend('error matlab','error householder', 'error givens');

disp('Relative Residue Part 1 on the system')
tableErrorSystem = table(arrayIndex', errorSolm', errorSolh', errorSolg', 'VariableNames', {'Step','MatlabResidue','HouseHolderResidue','GivensResidue'});
disp(tableErrorSystem)

figure
%subplot(3, 2, 2)
%plot(arrayIndex, errorSolOriginalm, '--o',  arrayIndex, errorSolOriginalh, '--o', arrayIndex, errorSolOriginalm, '--o');
semilogy(arrayIndex, errorSolOriginalm, '--o',  arrayIndex, errorSolOriginalh, '--o', arrayIndex, errorSolOriginalg, '--o');
title('Relative Error part2');
xlabel('Step');
ylabel('Error');
legend('error matlab','error householder', 'error givens');

disp('Relative Error Part 2 on the original solution')
tableErrorOnSolution = table(arrayIndex', errorSolOriginalm', errorSolOriginalh', errorSolOriginalg', 'VariableNames', {'Step','MatlabError','HouseHolderError','GivensError'});
disp(tableErrorOnSolution)

figure
%subplot(3, 2, 3)
%plot(arrayIndex, tm, '--o',  arrayIndex, th, '--o', arrayIndex, tg, '--o');
semilogy(arrayIndex, tm, '--o',  arrayIndex, th, '--o', arrayIndex, tg, '--o');
title('Time');
xlabel('Step');
ylabel('Time');
legend('time matlab','time householder', 'time givens');

disp('Time')
tableTime = table(arrayIndex', tm', th', tg', 'VariableNames', {'Step','MatlabTime','HouseHolderTime','GivensTime'});
disp(tableTime)

figure
%subplot(3, 2, 4)
%plot(arrayIndex, errorQRm, '--o',  arrayIndex, errorQRh, '--o', arrayIndex, errorQRg, '--o');
semilogy(arrayIndex, errorQRm, '--o',  arrayIndex, errorQRh, '--o', arrayIndex, errorQRg, '--o');
title('Factoring error');
xlabel('Step');
ylabel('Error');
legend('error matlab','error householder', 'error givens');

disp('Factoring error')
tableErrorFactoring = table(arrayIndex', errorQRm', errorQRh', errorQRg', 'VariableNames', {'Step','MatlabError','HouseHolderError','GivensError'});
disp(tableErrorFactoring)

figure
%subplot(3, 2, 5)
%plot(arrayIndex, errorQm, '--o',  arrayIndex, errorQh, '--o', arrayIndex, errorQg, '--o');
semilogy(arrayIndex, errorQm, '--o',  arrayIndex, errorQh, '--o', arrayIndex, errorQg, '--o');
title('Q error');
xlabel('Step');
ylabel('Error');
legend('error matlab','error householder', 'error givens');

%% stampa dei dati, errori 

disp('Error of Q matrix')
tableErrorQ = table(arrayIndex', errorQm', errorQh', errorQg', 'VariableNames', {'Step','MatlabError','HouseHolderError','GivensError'});
disp(tableErrorQ)

%preserve your memory lol
clear arrayIndex
clear errorSolm errorSolh errorSolg
clear errorSolOriginalg errorSolOriginalm errorSolOriginalh errorSolOriginalm
clear tm th tg
clear errorQRm errorQRh errorQRg
clear errorQm errorQh errorQg

clear times

clear i m n