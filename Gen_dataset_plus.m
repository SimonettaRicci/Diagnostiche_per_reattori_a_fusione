function [dataset, AmpiezzaMod_samples_fin] = Gen_dataset_plus(metodo, PlasmaTime, AmpiezzaMod_samples, FreqMod_samples, Iterazioni, ErrorIntegral_const, ErrorB_meas, IDCtime, SaddleTime, parametriVariabili, deviazione, randomici)

    % Numero di campioni per configurazione
    batch = 1;

    % Inizializzazione
    AmpiezzaMod_samples_fin = [];
    dataset = [];

    % Generazione campioni random se richiesto
    if randomici
        AmpiezzaMod_samples = rand(Iterazioni, 3) * 30;
        FreqMod_samples      = rand(Iterazioni, 3) * 200;
    end

    % Loop su ciascuna iterazione
    for i = 1:Iterazioni

        if randomici
            AmpiezzaMod_samples_deviazione = campioni_Random(AmpiezzaMod_samples(i,:), batch, deviazione);
            FreqMod_samples_deviazione     = campioni_Random(FreqMod_samples(i,:), batch, deviazione);
        end

        % Inizializzazione struttura IDC per batch
        IDC.B_meas_IterazioniErrorIntegral = [];
        IDC.B_Stimato_array = [];
        IDC.Phi_Stimato_array = [];

        for j = 1:batch

            % Estrai parametri con deviazione se richiesto
            if parametriVariabili || randomici
                AmpiezzaMod_s = AmpiezzaMod_samples_deviazione(j,:);
                FreqMod_s     = FreqMod_samples_deviazione(j,:);
            end

            % Genera plasma per il batch
            ErrorIntegral = linspace(0, ErrorIntegral_const, Iterazioni);
            Plasma = Gen_plasma(PlasmaTime, AmpiezzaMod_s, FreqMod_s, 1, ErrorIntegral, ErrorB_meas, 0);

            % Stima matriciale
            IDC = stima_Matriciale_IDC(Plasma, IDCtime, 1, ErrorIntegral, 0, 0);

            % Salva campioni
            AmpiezzaMod_samples_fin = [AmpiezzaMod_samples_fin; AmpiezzaMod_s]; %#ok<AGROW>
            dataset = [dataset, IDC.B_Stimato_array]; %#ok<AGROW>
        end
    end

    % Salvataggio su file
    save dataset dataset
    save AmpiezzaMod_samples_fin AmpiezzaMod_samples_fin
end
