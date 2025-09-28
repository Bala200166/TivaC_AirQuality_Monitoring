filename1= 'bonjour.wav';  % Replace with your audio file
filename2 = 'notesFlute.wav';  % Replace with your audio file
[y, Fs1] = audioread(filename1);
[z, Fs2] = audioread(filename2);
disp(['Sampling frequency of the first audio file: ', num2str(Fs1), ' Hz']);
disp(['Sampling frequency of the second audio file: ', num2str(Fs2), ' Hz']);
signalAnalyzer(y, Fs1);
signalAnalyzer(z, Fs2);