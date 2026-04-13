function [IDC]= IDC_Modelling(IDC,IDCtime,Plasma,iterazione,ErrorIntegral)
%% Modelling delle coils (IDC)

    IDC.t = linspace(0,1,IDCtime);
    IDC.phi = linspace(0,2*pi-2*pi/8,8)';

    IDC.B_ideal = interp2(Plasma.t,Plasma.phi,Plasma.B,...
        IDC.t,IDC.phi);

    IDC.B_meas = normrnd(IDC.B_ideal,Plasma.ErrorBmeas) + cumsum(normrnd(0,ErrorIntegral(iterazione),size(IDC.B_ideal)),2);
    IDC.B_meas_IterazioniErrorIntegral=[IDC.B_meas_IterazioniErrorIntegral,mean(IDC.B_meas,2)];
    
end