function demod = delta_mabate_demod(mod_data, s0, f, fs)

%Demodulator for Modified-ABATE algorithm

len = length(mod_data);
x_dem = zeros(1,len);
step_size = zeros(1,len);

for i=2:len
    %Encoded data to e_hat conversion
    if mod_data(i) == 0
        e_hat = -1;
    else
        e_hat = 1;
    end
    
    %Modified ABATE Logic for step size
    if (mod_data(i) == mod_data(i-1) && step_size(i) < 8*s0)
        step_size(i) = (abs(step_size(i-1)) + s0)*e_hat;
        
    elseif (mod_data(i) == mod_data(i-1) && step_size(i) == 8*s0)
        step_size(i) = abs(step_size(i-1))*e_hat;
        
    else
        step_size(i) = s0*e_hat;
    end
    
    x_dem(i) = e_hat*abs(step_size(i)) + x_dem(i-1);
end

%Interpolation using LPF
demod = lowpass(x_dem, f, fs);