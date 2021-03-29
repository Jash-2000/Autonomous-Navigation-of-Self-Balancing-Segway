function [error] = error_ce(x, vds, vgs, ids)

% Calculates the error between predicted and experimental drain current 
% as a function of gate voltage and drain voltage using the Curtice-Ettenburg Model.

test_ids = zeros(size(ids));

v1 = repmat(vgs', 1, length(vds)).*(ones(length(vgs), length(vds)) + x(1)*ones(length(vgs),length(vds)).*(x(7)*ones(length(vgs), length(vds)) - repmat(vds, length(vgs), 1)));
test_ids = (x(2)*ones(length(vgs), length(vds)) + x(3)*v1 + x(4)*(v1.^2) + x(5)*(v1.^3)).*(tanh(x(6)*repmat(vds, length(vgs), 1)));

error = sum(sum((test_ids - ids).^2));
