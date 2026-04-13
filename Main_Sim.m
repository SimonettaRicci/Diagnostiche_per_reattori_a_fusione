function [IDC_array, Plasma, ErrorIntegral, str] = Main_Sim(metodo, ...
    PlasmaTime, AmpiezzaMod_samples, FreqMod_samples, Iterazioni, ErrorIntegral0, ErrorB_meas, IDCtime, Bo, FlagPrint, save_)

    % Genera un vettore di errori integrali da 0 al valore massimo
    ErrorIntegral = linspace(0, ErrorIntegral0, Iterazioni);

    % Generazione del plasma simulato
    Plasma = Gen_plasma(PlasmaTime, AmpiezzaMod_samples, FreqMod_samples, ...
        Iterazioni, ErrorIntegral, ErrorB_meas, Bo, FlagPrint);

    % Preallocazione array di strutture IDC
    IDC_array = cell(1, size(metodo, 2));

    % Loop sui metodi selezionati
    for i = 1:size(metodo, 2)

        switch metodo(i)
            case 1
                IDC = stima_NN_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral);
                if i == 1
                    str = 'neural net';
                else
                    str = [str, '__neural net']; %#ok<AGROW>
                end

            case 2
                IDC = stima_Matriciale_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral);
                if i == 1
                    str = 'matriciale';
                else
                    str = [str, '__matriciale']; %#ok<AGROW>
                end

            case 3
                IDC = stima_differenze_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral);
                if i == 1
                    str = 'differenza';
                else
                    str = [str, '__differenza']; %#ok<AGROW>
                end

            case 4
                IDC = stima_NN_matriciale_IDC(Plasma, IDCtime, Iterazioni, ErrorIntegral, FlagPrint, save_);
                if i == 1
                    str = 'MatricialeNN';
                else
                    str = [str, '__MatricialeNN']; %#ok<AGROW>
                end

            otherwise
                disp("Seleziona un metodo valido")
        end

        % Salva il risultato della simulazione per il metodo corrente
        IDC_array{i} = IDC;
    end
end
