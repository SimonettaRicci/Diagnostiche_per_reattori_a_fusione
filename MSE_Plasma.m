function [IDC] = MSE_Plasma(IDC,Plasma)
%% errore quadratico per modo 
    vettore_differenza = IDC.B_Stimato_array'-Plasma.AmpiezzaMod;
    erroreModo1= mean(vettore_differenza(:,1).^2);
    erroreModo2= mean(vettore_differenza(:,2).^2);
    erroreModo3= mean(vettore_differenza(:,3).^2);

    %errore medio totale rispetto i singoli modi 
    IDC.MSE_ModiTotale = [erroreModo1,erroreModo2,erroreModo3];

    %errore medio in funzione di Iterazioni
    IDC.MSE_ModiEI=(sum(vettore_differenza,2).^2)/3;
end