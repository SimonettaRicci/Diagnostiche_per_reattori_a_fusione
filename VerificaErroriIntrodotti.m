function VerificaErroriIntrodotti(ErrorIntegral0,Iterazioni,IDC)

ErrorIntegral = linspace(0,ErrorIntegral0,Iterazioni);
% Plot
figure;
plot(ErrorIntegral, IDC.ErrorMeas_array, 'LineWidth', 2);
yline(0.1, '--r', '10% ErrorIntegral');
xlabel('Iterazione');
ylabel('Errore relativo medio');
title('Errore relativo dovuto all errore di integrazione');
legend('Errore relativo per ogni coil', 'Soglia 10%');
grid on;


% Plot
figure;
plot( IDC.ErrorMeas_array, 'LineWidth', 2);
yline(0.05, '--r', '5% ErrorMeas');
end