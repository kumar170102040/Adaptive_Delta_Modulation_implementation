function snr_out = isnr(x, y)

% Function to compute snr of x wrt (x-y)
% isnr since snr function exists

num = norm(x)^2;
den = norm(x-y)^2;

snr_out = 10*log10(num/den);