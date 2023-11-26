[sig, fs] = audioread('C_01_01.wav');%read the signals
N = 114;%set the number of bands N = 16
ygenerated8_1 = tonevocoder(sig,fs,800,114);

%Check the final effects here
sound(sig,fs);
sound(ygenerated8_1,fs);
audiowrite('C_01_03_N=114_f=800Hz.wav',ygenerated8_1,fs);

t = 0:1/fs:(length(sig)-1)/fs;
f = fs*((-length(sig)/2):(length(sig)/2)-1)/length(sig);

Fxx =  abs(fftshift(fft(sig)));
Fxx1 = abs(fftshift(fft(ygenerated8_1)));

[Pxx,w] = pwelch(sig,[],[],1024,fs);
[Pxx1,w1] = pwelch(ygenerated8_1,[],[],1024,fs);

figure(1);
subplot(2,1,1);plot(f,Fxx);xlabel('frequency/Hz');ylabel('fft');
title('original signal');
subplot(2,1,2);plot(f,Fxx1);xlabel('frequency/Hz');ylabel('fft');
title('N=114，the LPF cut-off frequency: 800 Hz');

figure(2);
subplot(2,1,1);plot(w,20*log10(Pxx));xlabel('frequency/Hz');ylabel('psd/dB');
title('original signal');
subplot(2,1,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');
title('N=114，the LPF cut-off frequency: 800 Hz');

figure(3);
subplot(2,1,1);plot(t,sig);xlabel('time/s');ylabel('sig Amp');
title('original signal');
subplot(2,1,2);plot(t,ygenerated8_1);xlabel('time/s');ylabel('sig Amp');
title('the LPF cut-off frequency: 800 Hz');