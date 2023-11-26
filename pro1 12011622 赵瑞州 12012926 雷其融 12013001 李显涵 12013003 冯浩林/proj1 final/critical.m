[sig,fs] = audioread('C_01_01.wav');%read the signals
LPF_cutoff_frequency=50;%set the cut-off frequency to 50 Hz
N = length(sig);
f = fs*(-N/2:N/2-1)/N;

ygenerated5_1 = tonevocoder(sig,fs,50,32);
ygenerated5_2 = tonevocoder(sig,fs,50,64);
ygenerated5_3 = tonevocoder(sig,fs,50,96);
ygenerated5_4 = tonevocoder(sig,fs,50,128);
ygenerated5_5 = tonevocoder(sig,fs,50,160);
%Check the final effects here
%sound(sig,fs);
%sound(ygenerated5_1,fs);
%sound(ygenerated5_2,fs);
%sound(ygenerated5_3,fs);
%sound(ygenerated5_4,fs);
%sound(ygenerated5_5,fs);

%% To get psd
[Pxx0,w0] = pwelch(sig,[],[],1024,fs);
[Pxx1,w1] = pwelch(ygenerated5_1,[],[],1024,fs);
[Pxx2,w2] = pwelch(ygenerated5_2,[],[],1024,fs);
[Pxx4,w4] = pwelch(ygenerated5_3,[],[],1024,fs);
[Pxx6,w6] = pwelch(ygenerated5_4,[],[],1024,fs);
[Pxx8,w8] = pwelch(ygenerated5_5,[],[],1024,fs);

%% plot    
figure(1);
subplot(3,2,1);plot(f,fftshift(abs(fft(sig'))));xlabel('frequency/Hz');ylabel('sig Amp');title('original')
subplot(3,2,2);plot(f,fftshift(abs(fft(ygenerated5_1))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=32')
subplot(3,2,3);plot(f,fftshift(abs(fft(ygenerated5_2))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=64')
subplot(3,2,4);plot(f,fftshift(abs(fft(ygenerated5_3))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=96')
subplot(3,2,5);plot(f,fftshift(abs(fft(ygenerated5_4))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=128')
subplot(3,2,6);plot(f,fftshift(abs(fft(ygenerated5_5))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=160')
figure(2);
subplot(3,2,1);plot(w0,20*log10(Pxx0));xlabel('frequency/Hz');ylabel('psd/dB');title('original');
subplot(3,2,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');title('N=32');
subplot(3,2,3);plot(w2,20*log10(Pxx2));xlabel('frequency/Hz');ylabel('psd/dB');title('N=64');
subplot(3,2,4);plot(w4,20*log10(Pxx4));xlabel('frequency/Hz');ylabel('psd/dB');title('N=96');
subplot(3,2,5);plot(w6,20*log10(Pxx6));xlabel('frequency/Hz');ylabel('psd/dB');title('N=128');
subplot(3,2,6);plot(w8,20*log10(Pxx8));xlabel('frequency/Hz');ylabel('psd/dB');title('N=160');
%% plot    
figure(3);
subplot(3,2,1);plot((0:length(sig)-1)/fs,sig);xlabel('time/s');ylabel('sig Amp');title('original')
subplot(3,2,2);plot((0:length(ygenerated5_1)-1)/fs,ygenerated5_1);xlabel('time/s');ylabel('sig Amp');title('N=32')
subplot(3,2,3);plot((0:length(ygenerated5_2)-1)/fs,ygenerated5_2);xlabel('time/s');ylabel('sig Amp');title('N=64')
subplot(3,2,4);plot((0:length(ygenerated5_3)-1)/fs,ygenerated5_3);xlabel('time/s');ylabel('sig Amp');title('N=96')
subplot(3,2,5);plot((0:length(ygenerated5_4)-1)/fs,ygenerated5_4);xlabel('time/s');ylabel('sig Amp');title('N=128')
subplot(3,2,6);plot((0:length(ygenerated5_5)-1)/fs,ygenerated5_5);xlabel('time/s');ylabel('sig Amp');title('N=160')