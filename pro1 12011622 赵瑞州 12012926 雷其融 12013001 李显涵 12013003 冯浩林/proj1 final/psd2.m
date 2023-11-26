[sig, fs] = audioread('C_01_01.wav');%read the signals
N = 4;%set the number of bands N = 4
ygenerated2_1 = tonevocoder(sig,fs,20,4);
ygenerated2_2 = tonevocoder(sig,fs,50,4);
ygenerated2_3 = tonevocoder(sig,fs,100,4);
ygenerated2_4 = tonevocoder(sig,fs,400,4);
 
t = 0:1/fs:(length(sig)-1)/fs;
f = fs*((-length(sig)/2):(length(sig)/2)-1)/length(sig);
 
Fxx =  abs(fftshift(fft(sig)));
Fxx1 = abs(fftshift(fft(ygenerated2_1)));
Fxx2 = abs(fftshift(fft(ygenerated2_2)));
Fxx3 = abs(fftshift(fft(ygenerated2_3)));
Fxx4 = abs(fftshift(fft(ygenerated2_4)));
 
[Pxx,w] = pwelch(sig,[],[],1024,fs);
[Pxx1,w1] = pwelch(ygenerated2_1,[],[],1024,fs);
[Pxx2,w2] = pwelch(ygenerated2_2,[],[],1024,fs);
[Pxx3,w3] = pwelch(ygenerated2_3,[],[],1024,fs);
[Pxx4,w4] = pwelch(ygenerated2_4,[],[],1024,fs);

figure(1);
subplot(5,1,1);plot(t,sig);xlabel('t/s');ylabel('fft');
title('original signal');
subplot(5,1,2);plot(t,ygenerated2_1);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 20 Hz');
subplot(5,1,3);plot(t,ygenerated2_2);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 50 Hz');
subplot(5,1,4);plot(t,ygenerated2_3);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 100 Hz');
subplot(5,1,5);plot(t,ygenerated2_4);xlabel('t/s');ylabel('fft');
title('the LPF cut-off frequency: 400 Hz');

figure(2);
subplot(5,1,1);plot(f,Fxx);xlabel('frequency/Hz');ylabel('fft');
title('original signal');
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
title('original signal');
subplot(5,1,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 20 Hz');
subplot(5,1,3);plot(w2,20*log10(Pxx2));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 50 Hz');
subplot(5,1,4);plot(w3,20*log10(Pxx3));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 100 Hz');
subplot(5,1,5);plot(w4,20*log10(Pxx4));xlabel('frequency/Hz');ylabel('psd/dB');
title('the LPF cut-off frequency: 400 Hz');