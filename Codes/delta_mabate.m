function [encoded, pred] = delta_mabate(data, s0)

%Modified ABATE Algorithm
%Source - Innovations in Telecommunications, Part 1 - J. Manassah - Page 191

len = length(data);
step_size = zeros(1,len);
pred = zeros(1,len);
e_hat = zeros(1,len);       %Error vector

for i=2:len
    %Current Error
    e_n = data(i) - pred(i-1);
    %QZR
    if (e_n >= 0)
        e_hat(i) = 1;
    else
        e_hat(i) = -1;
    end
    
    %Modified ABATE Algorithm to change step_size
    if (e_hat(i) == e_hat(i-1) && step_size(i) < 8*s0)
        step_size(i) = (abs(step_size(i-1)) + s0)*e_hat(i);
        
    elseif (e_hat(i) == e_hat(i-1) && step_size(i) == 8*s0)
        step_size(i) = abs(step_size(i-1))*e_hat(i);
        
    else
        step_size(i) = s0*e_hat(i);
    end
    
    %Accumulator
    pred(i) = pred(i-1) + e_hat(i)*abs(step_size(i));
end

%Encoded data --> 0 for -1 and 1 for +1
encoded = e_hat >= 0;