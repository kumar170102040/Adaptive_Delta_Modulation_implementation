function demod = delta_mod_demod(mod_data, delta, f, fs)

%Demodulator for delta_modulation

len = length(mod_data);
x_dem = zeros(1,len);

for i=2:len
    %Encoded data to e_hat conversion
    if mod_data(i) == 0
        e_hat = -delta;
    else
        e_hat = delta;
    end
    %DM output reconstruction
    x_dem(i) = e_hat + x_dem(i-1);
end

%Interpolation using LPF
demod = lowpass(x_dem, f, fs);