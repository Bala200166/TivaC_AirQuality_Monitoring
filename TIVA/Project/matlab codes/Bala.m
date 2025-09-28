clear all
clc
% Load the audio file
filename = 'chord_MI_SOL.wav';  % Replace with your audio file
[y, Fs] = audioread(filename);  % y is the signal, Fs is the sampling frequency

% Calculate the original signal properties
num_samples = length(y);               % Number of samples in the audio file
time_duration_original = num_samples / Fs;  % Original time duration

% Display original properties
disp(['Original Sampling Frequency: ', num2str(Fs), ' Hz']);
disp(['Original Time Duration: ', num2str(time_duration_original), ' seconds']);

% Subsampling by a factor of 4
factor = 7;
y_subsampled = y(1:factor:end);  % Take every 4th sample

% New sampling frequency after subsampling
%Fs_new = Fs / factor;

% Calculate time duration after subsampling
% Time duration should be based on original sample count and sampling rate
time_duration_subsampled = (length(y_subsampled) / Fs);

% Display results
%disp(['New Sampling Frequency (Fs_new): ', num2str(Fs), ' Hz']);
disp(['Time Duration After Subsampling (should match original): ', num2str(time_duration_subsampled), ' seconds']);

% Validate if the durations are approximately equal
if abs(time_duration_subsampled - time_duration_original) < 1e-10
    disp('The time durations match as expected.');
else
    disp('The time durations do not match exactly due to rounding.');
end