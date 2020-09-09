function [encoded, pred] = delta_msong(data, s0, a, b)

%Modified SONG Algorithm
%Source  - Adaptive Delta Modulation Techniques, Niranjan U, M.N. Suma

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
    
    %Modified SONG Algorithm to change step_size
    if (e_hat(i) == e_hat(i-1))
        step_size(i+1) = (a*abs(step_size(i)) + s0)*e_hat(i);
        
    elseif (e_hat(i) ~= e_hat(i-1) && b*step_size(i) > s0)
        step_size(i+1) = (b*abs(step_size(i)) - s0)*e_hat(i);
        
    elseif (e_hat(i) ~= e_hat(i-1) && b*step_size(i) < s0)
        step_size(i+1) = s0*e_hat(i);
        
    end
    
    %Accumulator
    pred(i) = pred(i-1) + e_hat(i)*abs(step_size(i));
end

%Encoded data --> 0 for -1 and 1 for +1
encoded = e_hat >= 0;