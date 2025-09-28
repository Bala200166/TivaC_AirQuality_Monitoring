
% Load the audio file
filename = 'chord_MI_SOL.wav';  % Replace with your actual file path
[y, Fs_orig] = audioread(filename);  % y is the original audio signal, Fs_orig is the original sampling rate

% Calculate the original duration
original_duration = length(y) / Fs_orig;  % Duration in seconds
disp(['Original Sampling Frequency: ', num2str(Fs_orig), ' Hz']);
disp(['Original Duration of Signal: ', num2str(original_duration), ' seconds']);

% Set the subsampling factor to 4
factor = 1/2;
new_Fs = Fs_orig * factor;  % New sampling frequency after downsampling

% Downsample by keeping every 4th sample
down_factor = round(1 / factor);  % This will be 4 in this case
y_resampled = y(1:down_factor:end);  % Subsampled signal

% Calculate the duration of the new signal
num_samples_resampled = length(y_resampled);  % Number of samples in y_resampled
new_duration = num_samples_resampled / new_Fs;  % New duration in seconds

% Display the results
disp(['New Sampling Frequency: ', num2str(new_Fs), ' Hz']);
disp(['New Duration of Resampled Signal: ', num2str(new_duration), ' seconds']);
disp(['Original Duration (should match new duration): ', num2str(original_duration), ' seconds']);
