
function [gradient,MSE] = ModelGradient_Supervised(dlX,dlY,parameters,Layer)

% Predict with the model
dlY_p = Network_FC(dlX,parameters,1,Layer);

% Compare prediction with targets
MSE = mean((dlY_p-dlY).^2,'all');

% Evaluate Gradients
gradient = dlgradient(MSE,parameters);

end

