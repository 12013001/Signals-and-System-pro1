[sig, fs] = audioread('C_01_01.wav');%read the signals
N = 4;%set the number of bands N = 4
%Generate SSN
N = length(sig);
[Psig,w] = periodogram(sig,[],512,fs);
bssn = fir2(3000,w/(fs/2),sqrt(Psig/max(Psig)));
noise = 1-2*rand(1,length(bssn)+N);
ssn = filter(bssn,1,noise);
ssn = ssn((length(bssn)+1):end);

%Generate a noise signal at SNR=-5dB
ssn = ssn/norm(ssn) * norm(sig)*10^0.25;
yns = sig.'+ ssn;
ygenerated4_1 = tonevocoder(yns,fs,20,6);
ygenerated4_2 = tonevocoder(yns,fs,50,6);
ygenerated4_3 = tonevocoder(yns,fs,100,6);
ygenerated4_4 = tonevocoder(yns,fs,400,6);
 
t = 0:1/fs:(length(sig)-1)/fs;
f = fs*((-length(sig)/2):(length(sig)/2)-1)/length(sig);
 
Fxx =  abs(fftshift(fft(yns)));
Fxx1 = abs(fftshift(fft(ygenerated4_1)));
Fxx2 = abs(fftshift(fft(ygenerated4_2)));
Fxx3 = abs(fftshift(fft(ygenerated4_3)));
Fxx4 = abs(fftshift(fft(ygenerated4_4)));
 
[Pxx,w] = pwelch(yns,[],[],512,fs);
[Pxx1,w1] = pwelch(ygenerated4_1,[],[],512,fs);
[Pxx2,w2] = pwelch(ygenerated4_2,[],[],512,fs);
[Pxx3,w3] = pwelch(ygenerated4_3,[],[],512,fs);
[Pxx4,w4] = pwelch(ygenerated4_4,[],[],512,fs);

figure(1);
subplot(5,1,1);plot(t,yns);xlabel('t/s');ylabel('fft');
title('noisy signal');
subplot(5,1,2);plot(t,ygenerated4_1);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 20 Hz');
subplot(5,1,3);plot(t,ygenerated4_2);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 50 Hz');
subplot(5,1,4);plot(t,ygenerated4_3);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 100 Hz');
subplot(5,1,5);plot(t,ygenerated4_4);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 400 Hz');

figure(2);
subplot(5,1,1);plot(f,Fxx);xlabel('frequency/Hz');ylabel('fft');
title('noisy signal');
subplot(5,1,2);plot(f,Fxx1);xlabel('frequency/Hz');ylabel('fft');
title('the LPF cut-off frequency: 20 Hz');
subplot(5,1,3);plot(f,Fxx2);xlabel('frequency/Hz');ylabel('fft');
title('the LPF cut-off frequency: 50 Hz');
subplot(5,1,4);plot(f,Fxx3);xlabel('frequency/Hz');ylabel('fft');
title('the LPF cut-off frequency: 100 Hz');
subplot(5,1,5);plot(f,Fxx4);xlabel('frequency/Hz');ylabel('fft');
title('the LPF cut-off frequency: 400 Hz');
 
figure(3);
subplot(5,1,1);plot(w,20*log10(Pxx));xlabel('frequency/Hz');ylabel('psd/dB');
title('noisy signal');
subplot(5,1,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 20 Hz');
subplot(5,1,3);plot(w2,20*log10(Pxx2));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 50 Hz');
subplot(5,1,4);plot(w3,20*log10(Pxx3));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 100 Hz');
subplot(5,1,5);plot(w4,20*log10(Pxx4));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 400 Hz');