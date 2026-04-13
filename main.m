clc, clear all, close all; %#ok<CLALL>
%aggiungere i grafici di confronto con il metodo dei saddle coil 
%unità di misura 
%mostrare che singolarmente gli errori sono nel range descritto andando ad
%eliminare le altre componenti 
%mettere il metodo matriciale in una slide a se stante



%% Parametri di simulazione base
PlasmaTime   = 1000;
Iterazioni   = 1000;
IDCtime      = 10000;
SaddleTime   = 10000;

% Errori sui dati
ErrorIntegral0 = 0.1 / sqrt(Iterazioni); % errore integrale (per raggiungere ~10%)
ErrorB_meas    = 5;                      % errore sulle misure (5%)
Bo            = 0.1;                     % rumore sul campo

% Metodi selezionati: 1 = IDC_NN, 2 = IDC_matriciale, 3 = IDC_Differenza
metodo   = [2]; %#ok<NBRAK2>
FlagPrint = 1;      % stampa abilitata
save_     = 0;      % salvataggio figure disabilitato

% Parametri dei modi
AmpiezzaMod_samples = [10, 5, 2];
FreqMod_samples     = [100, 200, 300];

%% Impostazioni per dataset o errore variabile
ErrorIntegral_const = 0.2;
parametriVariabili  = 0;
randomici           = 1;
deviazione          = [0.2, 0.2, 0.2];  % variazione per ogni modo se abilitato

% Simulazione principale
[IDC_array, Plasma, ErrorIntegral, str] = Main_Sim( ...
    metodo, PlasmaTime, AmpiezzaMod_samples, FreqMod_samples, ...
    Iterazioni, ErrorIntegral0, ErrorB_meas, IDCtime, SaddleTime, Bo, 0, 0);

% Verifica errori introdotti 
% VerificaErroriIntrodotti(ErrorIntegral0, Iterazioni, IDC_array{1});

%% Se stampa attiva, genera plot
if FlagPrint
    IDC = IDC_array{1};

    %% Plot campo B nel plasma
    fig1 = figure(1); set(fig1, 'name', "Plot B");
    subplot(2,1,1); hold on; grid on; grid minor;
    plot(Plasma.phi, Plasma.B(:,100));
    plot(Plasma.phi, Plasma.B(:,110));
    plot(Plasma.phi, Plasma.B(:,120));
    plot(Plasma.phi, Plasma.B(:,130));
    xlabel("\phi [rad]"); ylabel("B [T]");

    subplot(2,1,2); hold on; grid on; grid minor;
    plot(Plasma.t, Plasma.B(1,:));
    plot(Plasma.t, Plasma.B(50,:));
    plot(Plasma.t, Plasma.B(100,:));
    plot(Plasma.t, Plasma.B(150,:));
    xlabel("t [s]"); ylabel("B [T]");
    sgtitle('Plot plasma');

    %% Plot misure delle coil IDC
    fig2 = figure(2); set(fig2, 'Name', "Coil IDC");

    % Didascalia ampiezza e frequenza
    txt = { ...
        ['Ampiezza = [' num2str(Plasma.AmpiezzaMod) ']'], ...
        ['Frequenza = [' num2str(Plasma.FreqMod) ']'] ...
    };
    dim = [0.1 0.02 0.8 0.05];  % posizione box testo

    subplot(2,1,1); hold on;
    plot(IDC.t, IDC.B_ideal);
    title('Campo ideale');
    legend({'coil 1', 'coil 2','coil 3', 'coil 4','coil 5', 'coil 6','coil 7', 'coil 8'});
    xlabel('Tempo[s]'); ylabel('B[mT]');

    subplot(2,1,2); hold on;
    plot(IDC.t, IDC.B_meas);
    title('Campo misurato');
    legend({'coil 1', 'coil 2','coil 3', 'coil 4','coil 5', 'coil 6','coil 7', 'coil 8'});
    xlabel('Tempo[s]'); ylabel('B[mT]');

    sgtitle(['Coil IDC, metodo ', str]);
    annotation('textbox', dim, 'String', txt, 'EdgeColor','none', 'HorizontalAlignment','left');

    if save_
        save_Figure(['Coil IDC, metodo ', str], fig2); %#ok<UNRCH>
    end

    %% Plot errori stimati per ciascun metodo
    leg1 = cell(1, size(IDC_array,2)+1);
    leg2 = cell(1, size(IDC_array,2)+1);
    leg3 = cell(1, size(IDC_array,2)+1);

    for i = 1:size(IDC_array,2)
        IDC = IDC_array{i};
        part = split(str,'__');

        for modo = 1:3
            fig = figure(2 + modo);
            plot(ErrorIntegral, IDC.B_Stimato_array(modo,:),'LineWidth', 1.5); hold on;

            if i == size(IDC_array,2)
                plot(ErrorIntegral, ones(size(ErrorIntegral)) * Plasma.AmpiezzaMod(modo), 'LineWidth', 1.5);
            end

            switch modo
                case 1, leg1{i} = ['modo 1 ', part{i}]; leg1{i+1} = 'ampiezza mod1'; legend(leg1);
                case 2, leg2{i} = ['modo 2 ', part{i}]; leg2{i+1} = 'ampiezza mod2'; legend(leg2);
                case 3, leg3{i} = ['modo 3 ', part{i}]; leg3{i+1} = 'ampiezza mod3'; legend(leg3);
            end

            xlabel('Errore'); ylabel('B[mT]');
            set(gca, 'FontSize', 20);
            sgtitle(['B stimato modo ', num2str(modo), ', metodo ', str]);
            annotation('textbox', dim, 'String', txt, 'EdgeColor','none', 'HorizontalAlignment','left');
        end
    end

    %% Plot errore MSE per confronto metodi
    fig9 = figure(9); set(fig9, 'Name', "Coil IDC MSE");
    leg = cell(1, size(IDC_array,2));

    for i = 1:size(IDC_array,2)
        IDC = IDC_array{i};
        plot(ErrorIntegral, IDC.MSE_ModiEI,'LineWidth', 1.5); hold on;
        part = split(str,'__');
        leg{i} = ['MSE ', part{i}];
        if i == size(IDC_array,2), legend(leg); end
    end

    xlabel('Errore'); ylabel('MSE');
    set(gca, 'FontSize', 20);
    sgtitle(['Coil IDC, MSE ', str]);
    annotation('textbox', dim, 'String', txt, 'EdgeColor','none', 'HorizontalAlignment','left');

    if save_
        save_Figure(['Coil IDC, MSE ', str], fig9); %#ok<UNRCH>
    end
end
