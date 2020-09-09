%EE330 Digital Communication Assignment - 15/11/19
%Adapative Delta Modulation Techniques and Comparison

%Devashish Taneja   - 170102026
%Guining Pertin     - 170102027
%Mohnish Kumar      - 170102040

clear;
clc;

%% Sin*Exp input

%Sin*exp function
len = 500;
t = linspace(0, 10, len);
Fs = 50; %1/(10/len)
amp = 5;
f = 2;
x1 = amp*sin(2*pi*f*t).*exp(-t);

%% 0. Delta Modulation
    
delta = 1;  %Controllable parameter 0.4 for f = 1
[dm_out, dm_pred] = delta_mod(x1, delta);
% Demodulation
dm_demod = delta_mod_demod(dm_out, delta, f, Fs);
% MSE
dm_pred_snr1  = isnr(x1, dm_pred);
dm_demod_mse1  = immse(x1, dm_demod);

%% 1. Jayant Algorithm

[jayant_out, jayant_pred] = jayant_adm_modulator(x1);
% Demodulation
jayant_demod = jayant_adm_demodulator(jayant_out, f, Fs);
% MSE
jayant_pred_snr1  = isnr(x1, jayant_pred');
jayant_demod_mse1  = immse(x1, jayant_demod');

%% 2. SONG Algorithm

s0 = 0.5; %Controllable parameter 0.15 for f = 1
[song_out, song_pred] = delta_song(x1, s0);
% Demodulation
song_demod = delta_song_demod(song_out, s0, f, Fs);
% MSE
song_pred_snr1  = isnr(x1, song_pred);
song_demod_mse1  = immse(x1, song_demod);

%% 3. Modified ABATE Algorithm

s0 = 0.179; %Controllable parameter 0.1 for f = 1
[mabate_out, mabate_pred] = delta_mabate(x1, s0);
% Demodulation
mabate_demod = delta_mabate_demod(mabate_out, s0, f, Fs);
% MSE
mabate_pred_snr1  = isnr(x1, mabate_pred);
mabate_demod_mse1  = immse(x1, mabate_demod);

%% 4. Modified SONG Algorithm

s0 = 0.16; %Controllable parameter
a = 1.1;
b = 1/a;
[msong_out, msong_pred] = delta_msong(x1, s0, a, 1/a);
% Demodulation
msong_demod = delta_msong_demod(msong_out, s0, a, 1/a, f, Fs);
% MSE
msong_pred_snr1  = isnr(x1, msong_pred);
msong_demod_mse1  = immse(x1, msong_demod);

%% Comparison for X1 input

%Input and Predictor Output Comparison
figure(1);
subplot(5,1,1);
plot(t,x1);
title('Delta Modulation');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
stairs(t,dm_pred);
legend('Input', 'Delta Mod pred');

subplot(5,1,2);
plot(t,x1);
title('ADM - Jayant Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
stairs(t,jayant_pred');
legend('Input', 'Jayant pred');

subplot(5,1,3);
plot(t,x1);
title('ADM - SONG Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
stairs(t,song_pred);
legend('Input', 'SONG pred');

subplot(5,1,4);
plot(t,x1);
title('ADM - Modified ABATE Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
stairs(t,mabate_pred);
legend('Input', 'MABATE pred');

subplot(5,1,5);
plot(t,x1);
title('ADM - Modified SONG Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
stairs(t,msong_pred);
legend('Input', 'MSONG pred');

%Input and Demodulation Comparison
figure(2);
subplot(5,1,1);
plot(t,x1);
title('Delta Modulation');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
plot(t, dm_demod);
legend('Input', 'Demodulation');

subplot(5,1,2);
plot(t,x1);
title('ADM - Jayant Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
plot(t, jayant_demod');
legend('Input', 'Demodulation');

subplot(5,1,3);
plot(t,x1);
title('ADM - SONG Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
plot(t, song_demod);
legend('Input', 'Demodulation');

subplot(5,1,4);
plot(t,x1);
title('ADM - Modified ABATE Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
plot(t, mabate_demod);
legend('Input', 'Demodulation');

subplot(5,1,5);
plot(t,x1);
title('ADM - Modified SONG Algorithm');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
plot(t, msong_demod);
legend('Input', 'Demodulation');

%% Step input

%Step function
t = linspace(1,10,100);
f = 2;
Fs = 10;
amp = 5;
x2 = amp*(t >= 0 & t <= 5);

% 0. Delta Modulation
delta = 1;
[dm_out, dm_pred] = delta_mod(x2, delta);
% Demodulation
dm_demod = delta_mod_demod(dm_out, delta, f, Fs);
% MSE
dm_pred_snr2  = isnr(x2, dm_pred);
dm_demod_mse2  = immse(x2, dm_demod);

% 1. Jayant Algorithm
[jayant_out, jayant_pred] = jayant_adm_modulator(x2);
% Demodulation
jayant_demod = jayant_adm_demodulator(jayant_out, f, Fs);
% MSE
jayant_pred_snr2  = isnr(x2, jayant_pred');
jayant_demod_mse2  = immse(x2, jayant_demod');

% 2. SONG Algorithm
s0 = 0.5;
[song_out, song_pred] = delta_song(x2, s0);
% Demodulation
song_demod = delta_song_demod(song_out, s0, f, Fs);
% MSE
song_pred_snr2  = isnr(x2, song_pred);
song_demod_mse2  = immse(x2, song_demod);

% 3. Modified ABATE Algorithm
s0 = 0.179;
[mabate_out, mabate_pred] = delta_mabate(x2, s0);
% Demodulation
mabate_demod = delta_mabate_demod(mabate_out, s0, f, Fs);
% MSE
mabate_pred_snr2  = isnr(x2, mabate_pred);
mabate_demod_mse2  = immse(x2, mabate_demod);

% 4. Modified SONG Algorithm
s0 = 0.16;
a = 1.1;
[msong_out, msong_pred] = delta_msong(x2, s0, a, 1/a);
% Demodulation
msong_demod = delta_msong_demod(msong_out, s0, a, b, f, Fs);
% MSE
msong_pred_snr2  = isnr(x2, msong_pred);
msong_demod_mse2  = immse(x2, msong_demod);

%% Comparison for Step input

figure(3);
subplot(2,1,1)
plot(t,x2);
hold on;
plot(t, dm_pred);
plot(t, jayant_pred);
plot(t, song_pred);
plot(t, mabate_pred);
plot(t, msong_pred);
title('Step Input Comparison - Prediction');
xlabel('Time(s)');
ylabel('Amplitude(V)');
legend('Input', 'Delta', 'Jayant', 'SONG', 'M-ABATE', 'M-SONG');

subplot(2,1,2)
plot(t,x2);
hold on;
plot(t, dm_demod);
plot(t, jayant_demod);
plot(t, song_demod);
plot(t, mabate_demod);
plot(t, msong_demod);
title('Step Input Comparison - Demodulation');
xlabel('Time(s)');
ylabel('Amplitude(V)');
legend('Input', 'Delta', 'Jayant', 'SONG', 'M-ABATE', 'M-SONG');

%% MSE Comparison

fprintf("Mean Squared Error Comparison\n\n");
fprintf("Modulation Scheme-\tPred-SNR-X1-\t\tDemod-MSE-X1-\t\tPred-SNR-X2-\t\tDemod-MSE-X2-\n\n");
fprintf("Delta Modulation \t: %d\t\t%d\t\t%d\t\t%d\n", ...
    dm_pred_snr1, dm_demod_mse1, dm_pred_snr2, dm_demod_mse2);
fprintf("Jayant Algorithm \t: %d\t\t%d\t\t%d\t\t%d\n", ...
    jayant_pred_snr1, jayant_demod_mse1, jayant_pred_snr2, jayant_demod_mse2);
fprintf("SONG Algorithm \t\t: %d\t\t%d\t\t%d\t\t%d\n", ...
    song_pred_snr1, song_demod_mse1, song_pred_snr2, song_demod_mse2);
fprintf("M-ABATE Algorithm \t: %d\t\t%d\t\t%d\t\t%d\n",...
    mabate_pred_snr1, mabate_demod_mse1, mabate_pred_snr2, mabate_demod_mse2);
fprintf("M-SONG Algorithm \t: %d\t\t%d\t\t%d\t\t%d\n",...
    msong_pred_snr1, msong_demod_mse1, msong_pred_snr2, msong_demod_mse2);
fprintf("\nSNR - Higher is better, MSE - Lower is better\n");
