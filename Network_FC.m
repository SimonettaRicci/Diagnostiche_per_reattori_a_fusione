
function [Y,parameters] = Network_FC(X,parameters,Predict,Layer)

%% FFT Layer
% n_modes = [1 2 3 4 5 6 7 8];
% phi_coils = linspace(0,2*pi-2*pi/8,8)';
% W = [sin(phi_coils*n_modes) cos(phi_coils*n_modes)];
% W = dlarray(W');
% b = dlarray(zeros(size(W,1),1));
% 
% X = fullyconnect(X,W,b);
% % 
% I = max(X)-min(X);
% 
% X = X./I;

if Predict == 0 % it means that we want to initialise the neural network

    parameters = [];

    for i = 1 : length(Layer)

        parameters.("p"+i).weights = dlarray(randn([Layer(i) size(X,1)])*sqrt(2/Layer(i)));
        parameters.("p"+i).bias = dlarray(zeros([Layer(i) 1]));

        % X = fullyconnect(X,parameters.("p"+i).weights,parameters.("p"+i).bias);
        X = fullyconnect(X,parameters.("p"+i).weights,parameters.("p"+i).bias, 'DataFormat', 'CB');
        X = tanh(X);

    end

    parameters.output.weights = dlarray(randn([3 size(X,1)]))/3;
    parameters.output.bias = dlarray(zeros([3 1]));

    Y = fullyconnect(X,parameters.output.weights,parameters.output.bias);


elseif Predict == 1 % it means that we want to predict Y given X and parameters

    for i = 1 : length(Layer)
        X = fullyconnect(X,parameters.("p"+i).weights,parameters.("p"+i).bias);
        X = tanh(X);
    end

    Y = fullyconnect(X,parameters.output.weights,parameters.output.bias);

end

% Y = Y.*I;

end


