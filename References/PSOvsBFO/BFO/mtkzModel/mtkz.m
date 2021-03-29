function [test_ids_mtkz] = mtkz(X_gbest, vds, vgs)

% Calculates the value of drain current as a function of gate voltage and drain
% voltage using the Materka-Kacprzak Model

test_ids_mtkz = X_gbest(1).*((ones(length(vgs), length(vds)) - repmat(vgs', 1, length(vds))./(X_gbest(2).*ones(length(vgs), length(vds)) + X_gbest(4).*repmat(vds, length(vgs), 1))).^2).*tanh(X_gbest(3).*(repmat(vds, length(vgs), 1))./(repmat(vgs', 1, length(vds)) - X_gbest(2).*ones(length(vgs), length(vds)) - X_gbest(4).*repmat(vds, length(vgs), 1)));   





