% Upload and read the audio file
[audio_signal, fs] = audioread('HaydnL.wav'); % Replace with your file name

% Parameters
Th1 = 0.01032; % Threshold for filtered band F1
Th2 = 0.01032; % Threshold for filtered band F1*3
F1 = 50;   % Frequency for bandpass filter (adjust as needed)

% Normalize the audio signal
audio_signal = audio_signal / max(abs(audio_signal)); % Normalize to [-1, 1]

% Duration of signal in seconds
signal_duration = length(audio_signal) / fs;

% Segment duration and number of samples per segment
segment_duration = 0.5; % in seconds
segment_samples = round(fs * segment_duration);
num_segments = floor(length(audio_signal) / segment_samples);

% Initialize activation
activation = false;

for i = 1:num_segments
    % Extract a segment of the audio signal
    segment = audio_signal((i-1)*segment_samples + 1:i*segment_samples);

    % Compute the power of the segment
    Px_n = mean(segment.^2);

    if Px_n > Th1
        % Bandpass filter F1
        bpFilt1 = designfilt('bandpassiir', 'FilterOrder', 4, ...
                             'HalfPowerFrequency1', F1-5, ...
                             'HalfPowerFrequency2', F1+5, ...
                             'SampleRate', fs);
        Yf1 = filter(bpFilt1, segment);

        % Compute power of the filtered signal Yf1
        Pyf1 = mean(Yf1.^2);

        % Bandpass filter F1*3
        bpFilt2 = designfilt('bandpassiir', 'FilterOrder', 4, ...
                             'HalfPowerFrequency1', 3*F1-5, ...
                             'HalfPowerFrequency2', 3*F1+5, ...
                             'SampleRate', fs);
        Yf2 = filter(bpFilt2, segment);

        % Compute power of the filtered signal Yf2
        Pyf2 = mean(Yf2.^2);

        % Display the thresholds and filtered signal powers
        disp(['Threshold Th1: ', num2str(Th1)]);
        disp(['Threshold Th2: ', num2str(Th2)]);
        disp(['PYF1: ', num2str(Pyf1)]);  % Corrected line
        disp(['PYF2: ', num2str(Pyf2)]);  % Corrected line
        
        % Check thresholds for filtered signals
        if Pyf1 > Th1 && Pyf2 > Th2
            activation = true;
            disp(['Activation triggered at segment ', num2str(i)]);
            break;
        end
    end
end

if ~activation
    disp('No activation triggered.');
end
