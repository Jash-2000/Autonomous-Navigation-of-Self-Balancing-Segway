function cost_value=cost_func(k,plotfig,reference, output,t)

assignin('base', 'P',k(1))
assignin('base', 'I',k(2))
assignin('base', 'D',k(3))

error_triggered = false;

try % to avoid run time error in case of unstable parameters
    sim('dcmotor.mdl')
catch ME
    if (strcmp(ME.identifier,'Simulink:Engine:DerivNotFinite'))
        cost_value = inf;
        error_triggered = true;
    else
        rethrow(ME)
    end
end
if ~error_triggered
    err = reference - output;
    [n,~]=size(err);
    cost_value=0;
    for i=1:n
        %  cost_value=cost_value+(err(i))^2 ;  % ISE
        %   cost_value=cost_value+abs(err(i));  % IAE
        cost_value=cost_value+t(i)*abs(err(i));  % ITAE
        %   cost_value=cost_value+t(i)*(err(i))^2;  % MSE
    end
    %   cost_value=cost_value/t(n);  % MSE
    
    if plotfig
        figure(3)
        plot(t,reference,t,output)
    end
end
end
