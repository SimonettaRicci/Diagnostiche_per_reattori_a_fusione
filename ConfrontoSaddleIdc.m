function ConfrontoSaddleIdc(metodo,PlasmaTime, AmpiezzaMod_samples, ...
    FreqMod_samples,Iterazioni,ErrorIntegral0,ErrorB_meas,IDCtime,SaddleTime,Bo)

ErrorIntegral = linspace(0,ErrorIntegral0,Iterazioni);

[data,Plasma] = data_gen(PlasmaTime, AmpiezzaMod_samples,FreqMod_samples, ...
    Iterazioni,ErrorIntegral,ErrorB_meas,IDCtime,SaddleTime,Bo,0,0);

IDC=stima_differenze_IDC(Plasma,IDCtime,Iterazioni,ErrorIntegral,0,0);

SC=stima_SC(Plasma,SaddleTime,Iterazioni,ErrorIntegral);

figure();

plot(ErrorIntegral, IDC.B_Stimato_array(1,:),'LineWidth', 1.5);
hold on
plot(ErrorIntegral,ErrorIntegral./ErrorIntegral.*Plasma.AmpiezzaMod(1),'LineWidth', 1.5);
hold on
plot(ErrorIntegral, SC.B_Stimato_array(1,:),'LineWidth', 1.5);
hold on
xlabel('Errore')
ylabel('B[mT]')
set(gca, 'FontSize', 20);
legend({'modo1 IDC', 'RIferimento modo1', 'modo1 SC'})

figure();

plot(ErrorIntegral, IDC.B_Stimato_array(2,:),'LineWidth', 1.5);
hold on
plot(ErrorIntegral,ErrorIntegral./ErrorIntegral.*Plasma.AmpiezzaMod(2),'LineWidth', 1.5);
hold on
plot(ErrorIntegral, SC.B_Stimato_array(2,:),'LineWidth', 1.5);
hold on
xlabel('Errore')
ylabel('B[mT]')
set(gca, 'FontSize', 20);
legend({'modo2 IDC', 'Riferimento modo2', 'modo2 SC'})

figure();

plot(ErrorIntegral, IDC.B_Stimato_array(3,:),'LineWidth', 1.5);
hold on
plot(ErrorIntegral,ErrorIntegral./ErrorIntegral.*Plasma.AmpiezzaMod(3),'LineWidth', 1.5);
hold on
plot(ErrorIntegral, SC.B_Stimato_array(3,:),'LineWidth', 1.5);
hold on
xlabel('Errore')
ylabel('B[mT]')
set(gca, 'FontSize', 20);
legend({'modo3 IDC', 'Riferimento modo3', 'modo3 SC'})



end