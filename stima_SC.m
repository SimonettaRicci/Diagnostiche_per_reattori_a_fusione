function [SC]=stima_SC(Plasma,SCtime,Iterazioni,ErrorIntegral)
% Calcola le differenze SC e stima ampiezza e fase dei primi tre modi
SC.B_Stimato_array  = [];
SC.B_array  = [];
SC.B_meas_IterazioniErrorIntegral=[];
for j = 1:Iterazioni
    %realizza il modello delle SC
    [SC]= SC_Modelling(SC,SCtime,Plasma,j,ErrorIntegral);



    %% Metodo delle differenze per ricavare i modi
    % Modo 1
    B_cos_mode1 = (SC.B_meas(1,:) - SC.B_meas(3,:)) / 2;
    B_sin_mode1 = (SC.B_meas(2,:) - SC.B_meas(4,:)) / 2;
    B_mode1     = sqrt(B_cos_mode1.^2 + B_sin_mode1.^2);

    % Modo 2
    B_cos_mode2 = ( SC.B_meas(1,:) - SC.B_meas(2,:) + SC.B_meas(3,:) - SC.B_meas(4,:) ) / 4;
    B_sin_mode2 = zeros(size(B_cos_mode2));
    B_mode2     = abs(B_cos_mode2);

    % Modo 3
    B_cos_mode3 = ( SC.B_meas(1,:) - SC.B_meas(3,:) ) / 4;    
    B_sin_mode3 = ( SC.B_meas(4,:) - SC.B_meas(2,:) ) / 4;    
    B_mode3     = sqrt(B_cos_mode3.^2 + B_sin_mode3.^2);


    %% Stima dei valori medi (ampiezze e fasi)
    SC.B_Stimato_array  = [SC.B_Stimato_array,[mean(B_mode1,2),    mean(B_mode2,2),    mean(B_mode3,2)]'];
    SC.B_array  = [SC.B_array,mean(SC.B_meas ,2)];
end
end