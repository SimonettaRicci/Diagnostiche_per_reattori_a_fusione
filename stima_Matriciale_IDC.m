function [IDC] = stima_Matriciale_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral)

    % Inizializzazione strutture di output
    IDC.B_meas_IterazioniErrorIntegral = [];
    IDC.B_Stimato_array = [];
    IDC.ErrorMeas_array = [];

    for j = 1:Iterazioni

        % Simula la misura del campo magnetico
        IDC = IDC_Modelling(IDC, IDCtime, Plasma, j, ErrorIntegral);

        % Calcolo dell'errore relativo medio sulla misura
        errore_rel = mean((IDC.B_meas(:) - IDC.B_ideal(:)) ./ abs(IDC.B_ideal(:)));
        IDC.ErrorMeas_array = [IDC.ErrorMeas_array, errore_rel];

        % Costruzione della matrice dei regressori per i modi n=1,2,3
        IDC.M = [ ...
            ones(size(IDC.phi)), ...
            sin(IDC.phi), cos(IDC.phi), ...
            sin(2*IDC.phi), cos(2*IDC.phi), ...
            sin(3*IDC.phi), cos(3*IDC.phi) ...
        ];

        % Stima dei coefficienti tramite soluzione ai minimi quadrati
        IDC.Stima = IDC.M \ IDC.B_meas;

        % Calcolo delle ampiezze e fasi dei modi stimati
        IDC.B_Stimato = [];

        for i = 2:2:size(IDC.Stima,1)
            amp = sqrt(IDC.Stima(i,:).^2 + IDC.Stima(i+1,:).^2);
            IDC.B_Stimato = [IDC.B_Stimato; mean(amp)];
        end

        % Salvataggio delle stime per ogni iterazione
        IDC.B_Stimato_array = [IDC.B_Stimato_array, IDC.B_Stimato];
    end

    % Calcolo finale dell'errore MSE rispetto al plasma ideale
    [IDC] = MSE_Plasma(IDC, Plasma);
end