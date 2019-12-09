%% SECONDA PARTE
% Grazie ai dati prestati dal docente, verifichiamo prima con risoluzione di
% un sistema con fattorizzazione QR, se riusciamo ad ottenere una N
% (superfici normali) di buona qualità.
%%
addpath Functions/
%load conchiglia.mat
load superficie1.mat
format short e

%ora ho L M N r s

%ottenere sistema L’ N = M’
Ltrasp = L';

Mtrasp = M';

%% con HouseHolder
%fatt QR di Ltrasp risoluzione sist minimi quadrati QR
[Qh, Rh] = HouseHolderQR(Ltrasp);

Nqrtesth = QRSystemResolution(Qh, Rh, Mtrasp);

%% con Givens
%fatt QR di Ltrasp risoluzione sist minimi quadrati QR
[Qg, Rg] = GivensQR(Ltrasp);

% Cg = Qg' * Mtrasp;
% 
% Nqrtestg= Rg\Cg;

Nqrtestg = QRSystemResolution(Qg, Rg, Mtrasp);

%% matlab
Nmatlab = Ltrasp\Mtrasp;

%% errore nella fattorizzazione
errFatt = norm(N'*L-M, inf);
errFattH = norm(Nqrtesth'*L-M, inf);
errFattG = norm(Nqrtestg'*L-M, inf);
errFattMat = norm(Nmatlab'*L-M, inf);

disp('')
disp('errore nella fattorizzazione')
disp([errFatt errFattH errFattG errFattMat])

%% errore sulle noramli
errNh = norm(N - Nqrtesth, inf);
errNg = norm(N - Nqrtestg, inf);  
errNmat = norm(N - Nmatlab, inf);
% come se stessimo prendendo per buona quella di matlab
errNmath = norm(Nmatlab - errNh, inf);
errNmatg = norm(Nmatlab - errNg, inf);

disp('')
disp('errore sulle normali')
disp([errNh errNg errNmat errNmath errNmatg])

%% errore relativo sulle normali
errNhRel = norm(N - Nqrtesth, inf)/ norm(N, inf);
errNgRel = norm(N - Nqrtestg, inf)/ norm(N, inf) ;  
errNmatRel = norm(N - Nmatlab, inf)/ norm(N, inf);
% come se stessimo prendendo per buona quella di matlab
errNmathRel = norm(Nmatlab - errNh, inf) / norm(Nmatlab, inf);
errNmatgRel = norm(Nmatlab - errNg, inf) / norm(Nmatlab, inf);

disp('')
disp('errore relativo sulle normali')
disp([errNhRel errNgRel errNmatRel errNmathRel errNmatgRel])

%stampa
figure
title('Relative Error, Normals');
xlabel('Resolution Methods');
ylabel('Relative Error');
    
bar(categorical({'Householder', 'Givens', 'Matlab'}),[errNhRel errNgRel errNmatRel]);
legend('error');




