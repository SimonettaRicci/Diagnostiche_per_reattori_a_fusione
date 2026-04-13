function [Plasma] = Gen_plasma (PlasmaTime, AmpiezzaMod,FreqMod,Iterazioni,ErrorIntegral,ErrorB_meas,Bo,FlagPrint )
NumMode = size(AmpiezzaMod,2);
Plasma.AmpiezzaMod=AmpiezzaMod;
Plasma.FreqMod = FreqMod;
Plasma.ErrorBmeas=ErrorB_meas;


%% Simulazione campo magnetico in funzione dell'angolo toroidale

% Angolo toroidale. Ref plasma
Plasma.phi = linspace(0,2*pi,200)';

% Definizione span temporale
Plasma.t = linspace(0,1,PlasmaTime);

% Intensità campo magnetico equilibrio
Plasma.B0 = 0*ones(size(Plasma.t));

% Vettore del numero toroidale
Plasma.n =[];
for i = 1: NumMode
    Plasma.n = [Plasma.n, i];
end


% Intensità campo modo n (modo 1, posizione 1, etc.
Plasma.Bn = [];
for i = 1 : NumMode
    Plasma.Bn = [Plasma.Bn;AmpiezzaMod(i)*ones(size(Plasma.t))];
end

% Frequenza dei modi n
Plasma.fn = [];
for i = 1 : NumMode
    Plasma.fn = [Plasma.fn;FreqMod(i)*ones(size(Plasma.t))];
end

% Fase dei modi n
Plasma.phin = normrnd(0,pi,size(Plasma.n));

% Oscillazioni di campo a caso
Plasma.Bosc = normrnd(0,Bo,length(Plasma.phi),length(Plasma.t));

% Generate Magnetic field
Plasma.B = Plasma.B0 + Plasma.Bosc;

for n = 1 : length(Plasma.n)
    Plasma.B = Plasma.B + ...
        Plasma.Bn(n,:).*sin(Plasma.fn(n,:).*Plasma.t.*2*pi + Plasma.phin(n) + Plasma.n(n).*Plasma.phi);
end
end