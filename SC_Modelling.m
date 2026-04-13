function [SC]= SC_Modelling(SC,SCtime,Plasma,iterazione,ErrorIntegral)
%% Modelling delle coils (SC)

    SC.t = linspace(0,1,SCtime);
    SC.phi = linspace(0,2*pi-2*pi/8,8)';

    SC.B_ideal = interp2(Plasma.t,Plasma.phi,Plasma.B,...
        SC.t,SC.phi);

    SC.B_meas = normrnd(SC.B_ideal,Plasma.ErrorBmeas) + cumsum(normrnd(0, ...
        ErrorIntegral(iterazione),size(SC.B_ideal)),2);
    SC.B_meas_IterazioniErrorIntegral=[SC.B_meas_IterazioniErrorIntegral,mean(SC.B_meas,2)];

end