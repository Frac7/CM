%% Pseudoinverse
% Calcolo della pseudoinversa tramite SVD
%%
function Api = PseudoInverse(A)
    %calcolo della fattorizzazione SVD di Matlab
    [U, S, V] = svd(A);
    
    %calolo della pseudoinversa di sigma: reciproco degli elementi diversi
    %da 0 nella trasposta
    Spi = S';
    Spi = 1./Spi;
    Spi(Spi(:) == inf) = 0;
    
    %in questa implementazione abbiamo a che fare con matrici in cui m < n,
    %quindi inversa a destra
    Api = V * Spi * U';
    
    %la pseudoinversa si calcola come V * sigma pseudoinversa * U traposta
end
