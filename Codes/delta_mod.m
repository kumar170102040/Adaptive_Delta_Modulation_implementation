function [encoded, pred] = delta_mod(data, delta)

%Delta Modulation Scheme

len = length(data);
pred = zeros(1,len);
e_hat = zeros(1,len); %Data to be encoded

for i=2:len
    %Error
    e_n = data(i) - pred(i-1);
    %QZR
    if (e_n >= 0)
        e_hat(i) = delta;
    else
        e_hat(i) = -delta;
    end
    %Accumulator
    pred(i) = pred(i-1) + e_hat(i);
end

%Encoded data --> 0 for -1 and 1 for +1
encoded = e_hat >= 0;
