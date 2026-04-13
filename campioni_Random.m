function [campioniMod_samples]=campioni_Random(campioniMod0,N,deviazione)
campuioniMod_samples = zeros(N, 3);
% per ogni colonna i=1..3 genero linspace attorno a AmpiezzaMod0 (i)
for i = 1:3
    campioniMod_samples(:,i) = linspace( campioniMod0(i)-deviazione(i), campioniMod0(i)+deviazione(i), N )';
end
end