function [IDC] = stima_NN_matriciale_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral)

    % Carica rete neurale di correzione (delta)
    load("netDelta.mat");

    % Esegue la stima matriciale standard
    IDC = stima_Matriciale_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral, false, false);

    % Applica correzione con rete neurale
    delta = netDelta(IDC.B_Stimato_array);

    % Correzione percentuale (invece della somma diretta)
    IDC.B_Stimato_array = IDC.B_Stimato_array ./ (1 - delta/100);
end