[sig,fs] = audioread('C_01_01.wav');%Choose 01 or 02

%-------------------Task1-------------------
figure;
graphmaker(sig,fs,50,1,0);figure;
graphmaker(sig,fs,50,2,0);figure;
graphmaker(sig,fs,50,4,0);figure;
graphmaker(sig,fs,50,6,0);figure;
graphmaker(sig,fs,50,8,0);figure;
 
%-------------------Task2-------------------
graphmaker(sig,fs,20,4,0);figure;
graphmaker(sig,fs,50,4,0);figure;
graphmaker(sig,fs,100,4,0);figure;
graphmaker(sig,fs,400,4,0);figure;

%-------------------Task3-------------------
%Generate SSN
N = length(sig);
noise = 1-2*rand(1,N);
[Psig,w] = periodogram(sig,[],512,fs);
bssn = fir2(3000,w/(fs/2),sqrt(Psig/max(Psig)));
ssn = filter(bssn,1,noise);

%Generate a noise signal at SNR=-5dB
ssn = ssn/norm(ssn) * norm(sig)*10^0.25;
yns = sig.'+ ssn;

[Pssn,w] = periodogram(ssn,[],512,fs);
subplot(2,1,1)
plot(ssn);
title('Speech-Shaped Noise');
xlabel('t');
ylabel('Amplitude');
subplot(2,1,2)
plot(w,10*log10(Pssn));
title('PSD of Speech-Shaped Noise');
xlabel('\omega/Hz');
ylabel('Pssn/dB');
figure;

graphmaker(yns,fs,50,2,1);figure;
graphmaker(yns,fs,50,4,1);figure;
graphmaker(yns,fs,50,6,1);figure;
graphmaker(yns,fs,50,8,1);figure;
graphmaker(yns,fs,50,16,1);figure;
 
%-------------------Task4-------------------
graphmaker(yns,fs,20,6,1);figure;
graphmaker(yns,fs,50,6,1);figure;
graphmaker(yns,fs,100,6,1);figure;
graphmaker(yns,fs,400,6,1);