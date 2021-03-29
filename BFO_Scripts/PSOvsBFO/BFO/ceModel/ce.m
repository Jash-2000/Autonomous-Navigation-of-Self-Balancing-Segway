function [test_ids_ce] = ce(X_gbest, vds, vgs)

% Calculates the value of drain current as a function of gate voltage and drain
% voltage using the Curtice-Ettenburg Model

v1 = repmat(vgs', 1, length(vds)).*(ones(length(vgs), length(vds)) + X_gbest(1)*ones(length(vgs),length(vds)).*(X_gbest(7)*ones(length(vgs), length(vds)) - repmat(vds, length(vgs), 1)));
test_ids_ce = (X_gbest(2)*ones(length(vgs), length(vds)) + X_gbest(3)*v1 + X_gbest(4)*(v1.^2) + X_gbest(5)*(v1.^3)).*(tanh(X_gbest(6)*repmat(vds, length(vgs), 1)));

