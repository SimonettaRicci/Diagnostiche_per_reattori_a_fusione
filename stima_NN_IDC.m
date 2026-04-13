function [IDC] = stima_NN_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral)

    % Inizializzazione delle strutture di output
    IDC.B_meas_IterazioniErrorIntegral = [];
    IDC.B_Stimato_array = [];

    % Simulazione misure IDC per ogni iterazione
    for j = 1:Iterazioni
        IDC = IDC_Modelling(IDC, IDCtime, Plasma, j, ErrorIntegral);
    end

    % Stima del campo con rete neurale
    IDC.B_Stimato_array = PredictNet(IDC.B_meas_IterazioniErrorIntegral', param, Layer);
    % Alternative con rete diversa:
    % IDC.B_Stimato_array = PredictNet(IDC.B_meas_IterazioniErrorIntegral', parameters_best, Layer);
    % IDC.stime = net(IDC.B_meas_IterazioniErrorIntegral);
    % IDC.B_Stimato_array = IDC.stime(1:3,:);


    % Calcolo dell'errore MSE
    [IDC] = MSE_Plasma(IDC, Plasma);
end


%% Funzione: Esecuzione della rete neurale su input normalizzato
function Bn = PredictNet(X, parameters, Layer)

    % Conversione e normalizzazione dell'input
    X = dlarray(X, "BC");
    I = std(X);
    X = X ./ I;

    % Esecuzione rete
    Bn = Network_FC(X, parameters, 1, Layer);
    Bn = Bn .* I;
    Bn = double(extractdata(gather(Bn)));
end
