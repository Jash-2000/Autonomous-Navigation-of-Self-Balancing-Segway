 function [error] = error_mtkz(x, vds, vgs, ids)
 
% Calculates the error between predicted and experimental drain current 
%as a function of gate voltage and drain voltage using the Materka-Kacprzak Model.

test_ids = zeros(size(ids));

test_ids = x(1).*((ones(length(vgs), length(vds)) - repmat(vgs', 1, length(vds))./(x(2).*ones(length(vgs), length(vds)) + x(4).*repmat(vds, length(vgs), 1))).^2).*tanh(x(3).*(repmat(vds, length(vgs), 1))./(repmat(vgs', 1, length(vds)) - x(2).*ones(length(vgs), length(vds)) - x(4).*repmat(vds, length(vgs), 1)));

error = sum(sum((test_ids - ids).^2));


