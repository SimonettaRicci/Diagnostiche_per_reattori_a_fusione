function [IDC] = stima_differenze_IDC(Plasma, IDCtime, Iterazioni,ErrorIntegral)

% Calcola le differenze IDC e stima ampiezza e fase dei primi tre modi
IDC.B_Stimato_array  = [];
IDC.Phi_Stimato_array = [];
IDC.B_array  = [];
IDC.B_meas_IterazioniErrorIntegral=[];
for j = 1:Iterazioni
    %realizza il modello delle IDC
    [IDC]= IDC_Modelling(IDC,IDCtime,Plasma,j,ErrorIntegral);



    %% Metodo delle differenze per ricavare i modi
    % Modo 1
    B_cos_mode1 = (IDC.B_meas(1,:) - IDC.B_meas(5,:)) / 2;
    B_sin_mode1 = (IDC.B_meas(3,:) - IDC.B_meas(7,:)) / 2;
    B_mode1     = sqrt(B_cos_mode1.^2 + B_sin_mode1.^2);

    % Modo 2
    B_cos_mode2 = (IDC.B_meas(1,:) - IDC.B_meas(3,:) + IDC.B_meas(5,:) - IDC.B_meas(7,:)) / 4;
    B_sin_mode2 = (IDC.B_meas(2,:) - IDC.B_meas(4,:) + IDC.B_meas(6,:) - IDC.B_meas(8,:)) / 4;
    B_mode2     = sqrt(B_cos_mode2.^2 + B_sin_mode2.^2);

    % Modo 3
    Diff_A = (IDC.B_meas(1,:) - IDC.B_meas(5,:)) / 2;
    Diff_B = (IDC.B_meas(2,:) - IDC.B_meas(6,:)) / (2*0.7071);
    Diff_C = (IDC.B_meas(7,:) - IDC.B_meas(3,:)) / 2;
    Diff_D = (IDC.B_meas(4,:) - IDC.B_meas(8,:)) / (2*0.7071);
    B_cos_mode3 = 0.5 * (Diff_A + Diff_D);
    B_sin_mode3 = 0.5 * (Diff_C + Diff_B);
    B_mode3     = sqrt(B_cos_mode3.^2 + B_sin_mode3.^2);

    %% Calcolo delle fasi istantanee
    phi_mode1 = atan2(B_sin_mode1, B_cos_mode1);
    phi_mode2 = atan2(B_sin_mode2, B_cos_mode2);
    phi_mode3 = atan2(B_sin_mode3, B_cos_mode3);

    %% Stima dei valori medi (ampiezze e fasi)
    IDC.B_Stimato_array  = [IDC.B_Stimato_array,[mean(B_mode1,2),    mean(B_mode2,2),    mean(B_mode3,2)]'];
    IDC.Phi_Stimato_array = [IDC.Phi_Stimato_array,[mean(phi_mode1,2), mean(phi_mode2,2), mean(phi_mode3,2)]'];
    IDC.B_array  = [IDC.B_array,mean(IDC.B_meas ,2)];
end
    [IDC] = MSE_Plasma(IDC,Plasma);
end
