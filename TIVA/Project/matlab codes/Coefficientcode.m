% Load the reference (password) audio signal
[audio_signal_ref, fs_ref] = audioread('Chord2.wav');  % Replace with the actual password signal file

% Load the test signal
[audio_signal_test, fs_test] = audioread('Chord2.wav');  % Replace with the test signal file

% Check if sampling rates match
if fs_ref ~= fs_test
    disp('Warning: Sampling rates do not match!');
    return;
end

% Normalize both the reference and test signals
audio_signal_ref = audio_signal_ref / max(abs(audio_signal_ref));  % Normalize reference
audio_signal_test = audio_signal_test / max(abs(audio_signal_test));  % Normalize test signal

% Load the filter coefficients
a1 = 1;  % FIR filter denominator is always 1
a2 = 1;  % FIR filter denominator is always 2
% Define Filter1 coefficients as a single row vector
b1 = [-0.0629476110312297,0.249996949243091,0.125889505004224,0.249996949243091,-0.0629476110312297];

% Define Filter2 coefficients as a single row vector
b2 = [-0.0649267773848838,0.249908286033808,0.129672386699614,0.249908286033808,-0.0649267773848838];

% Display the loaded filter coefficients for verification
disp('Filter coefficients for F1:');
disp('b1:'); disp(b1');
disp('a1:'); disp(a1');
disp('Filter coefficients for F3:');
disp('b2:'); disp(b2');
disp('a2:'); disp(a2');

% --- Plot Original Signal's Frequency Spectrum for Reference and Test Signal ---
figure;
subplot(2, 1, 1);
plot_frequency_spectrum(audio_signal_ref, fs_ref, 'Original Signal Freq Spectrum (Reference)');
subplot(2, 1, 2);
plot_frequency_spectrum(audio_signal_test, fs_ref, 'Original Signal Freq Spectrum (Test)');

% --- Process Password Signal ---
% Filter reference signal through F1
Yf1_ref = filter(b1, a1, audio_signal_ref);
% Compute and plot the frequency spectrum of the filtered signal
figure;
plot_frequency_spectrum(Yf1_ref, fs_ref, 'Filtered Signal F1 (Reference)');

% Find and display max/min frequency for filtered signal F1
[max_freq_f1, min_freq_f1] = find_max_min_freq(Yf1_ref, fs_ref);
disp(['Max Frequency (F1) Reference: ', num2str(max_freq_f1), ' Hz']);
disp(['Min Frequency (F1) Reference: ', num2str(min_freq_f1), ' Hz']);
Pyf1_ref = mean(Yf1_ref.^2);  % Power of the filtered signal F1

% Filter reference signal through F2
Yf2_ref = filter(b2, a2, audio_signal_ref);
% Compute and plot the frequency spectrum of the filtered signal
figure;
plot_frequency_spectrum(Yf2_ref, fs_ref, 'Filtered Signal F2 (Reference)');

% Find and display max/min frequency for filtered signal F2
[max_freq_f3, min_freq_f3] = find_max_min_freq(Yf2_ref, fs_ref);
disp(['Max Frequency (F2) Reference: ', num2str(max_freq_f3), ' Hz']);
disp(['Min Frequency (F2) Reference: ', num2str(min_freq_f3), ' Hz']);
Pyf2_ref = mean(Yf2_ref.^2);  % Power of the filtered signal F2

% Calculate Thresholds from the reference signal (password)
Th1 = 0.95 * Pyf1_ref;  % Threshold for filtered signal F1
Th2 = 0.95 * Pyf2_ref;  % Threshold for filtered signal F2

% Display the reference thresholds
disp(['Threshold Th1 (Reference): ', num2str(Th1)]);
disp(['Threshold Th2 (Reference): ', num2str(Th2)]);

% --- Process Test Signal ---
% Filter test signal through F1
Yf1_test = filter(b1, a1, audio_signal_test);
% Compute and plot the frequency spectrum of the filtered signal
figure;
plot_frequency_spectrum(Yf1_test, fs_ref, 'Filtered Signal F1 (Test)');

% Find and display max/min frequency for filtered signal F1
[max_freq_f1_test, min_freq_f1_test] = find_max_min_freq(Yf1_test, fs_ref);
disp(['Max Frequency (F1) Test: ', num2str(max_freq_f1_test), ' Hz']);
disp(['Min Frequency (F1) Test: ', num2str(min_freq_f1_test), ' Hz']);
Pyf1_test = mean(Yf1_test.^2);  % Power of the filtered signal F1

% Filter test signal through F2
Yf2_test = filter(b2, a2, audio_signal_test);
% Compute and plot the frequency spectrum of the filtered signal
figure;
plot_frequency_spectrum(Yf2_test, fs_ref, 'Filtered Signal F2 (Test)');

% Find and display max/min frequency for filtered signal F2
[max_freq_f3_test, min_freq_f3_test] = find_max_min_freq(Yf2_test, fs_ref);
disp(['Max Frequency (F2) Test: ', num2str(max_freq_f3_test), ' Hz']);
disp(['Min Frequency (F2) Test: ', num2str(min_freq_f3_test), ' Hz']);
Pyf2_test = mean(Yf2_test.^2);  % Power of the filtered signal F2

% Display the power of the filtered test signals
disp(['PYF1 (Test): ', num2str(Pyf1_test)]);
disp(['PYF2 (Test): ', num2str(Pyf2_test)]);

% --- Debugging Outputs ---
disp('--- Debugging Outputs ---');
disp(['Power of Filtered Reference Signal (F1): ', num2str(Pyf1_ref)]);
disp(['Power of Filtered Reference Signal (F2): ', num2str(Pyf2_ref)]);

disp(['Power of Filtered Test Signal (F1): ', num2str(Pyf1_test)]);
disp(['Power of Filtered Test Signal (F2): ', num2str(Pyf2_test)]);

% --- Activation Check ---
disp(['Comparing test power to thresholds:']);
disp(['Pyf1_test: ', num2str(Pyf1_test), ' | Th1: ', num2str(Th1)]);
disp(['Pyf2_test: ', num2str(Pyf2_test), ' | Th2: ', num2str(Th2)]);

% Compare powers
if Pyf1_test > Th1 && Pyf2_test > Th2
    disp('Activation: Password Accepted');
else
    disp('Activation: Password Rejected');
end

% Function to plot frequency spectrum
function plot_frequency_spectrum(signal, fs, title_str)
    n = length(signal);  % Number of samples
    signal_fft = fft(signal);  % Apply FFT to the signal
    mag_signal = abs(signal_fft);  % Magnitude of FFT
    f = (0:n-1)*(fs/n);  % Frequency axis

    % Only consider the positive frequencies
    f_positive = f(1:floor(n/2));  % Positive frequencies
    mag_signal_positive = mag_signal(1:floor(n/2));  % Magnitude for positive frequencies

    % Plot the magnitude spectrum
    plot(f_positive, mag_signal_positive);
    title(title_str);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
end

% Function to find max and min frequency of the signal
function [max_freq, min_freq] = find_max_min_freq(signal, fs)
    n = length(signal);  % Number of samples
    signal_fft = fft(signal);  % Apply FFT to the signal
    mag_signal = abs(signal_fft);  % Magnitude of FFT
    f = (0:n-1)*(fs/n);  % Frequency axis

    % Only consider the positive frequencies
    f_positive = f(1:floor(n/2));  % Positive frequencies
    mag_signal_positive = mag_signal(1:floor(n/2));  % Magnitude for positive frequencies

    % Find the maximum and minimum frequencies
    [~, max_index] = max(mag_signal_positive);  % Max magnitude index
    [~, min_index] = min(mag_signal_positive(mag_signal_positive > 0));  % Min magnitude index

    max_freq = f_positive(max_index);  % Max frequency
    min_freq = f_positive(min_index);  % Min frequency
end
