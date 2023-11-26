[sig,fs] = audioread('C_01_01.wav');%read the signals
LPF_cutoff_frequency=50;%set the cut-off frequency to 50 Hz
N = length(sig);
f = fs*(-N/2:N/2-1)/N;
ygenerated1_1 = tonevocoder(sig,fs,50,1);
ygenerated1_2 = tonevocoder(sig,fs,50,2);
ygenerated1_3 = tonevocoder(sig,fs,50,4);
ygenerated1_4 = tonevocoder(sig,fs,50,6);
ygenerated1_5 = tonevocoder(sig,fs,50,8);

%% To get psd
[Pxx0,w0] = pwelch(sig,[],[],1024,fs);
[Pxx1,w1] = pwelch(ygenerated1_1,[],[],1024,fs);
[Pxx2,w2] = pwelch(ygenerated1_2,[],[],1024,fs);
[Pxx4,w4] = pwelch(ygenerated1_3,[],[],1024,fs);
[Pxx6,w6] = pwelch(ygenerated1_4,[],[],1024,fs);
[Pxx8,w8] = pwelch(ygenerated1_5,[],[],1024,fs);

%% plot    
figure(1);
subplot(3,2,1);plot(0:N-1,sig);xlabel('t/s');ylabel('sig Amp');title('original')
subplot(3,2,2);plot(0:N-1,ygenerated1_1);xlabel('t/s');ylabel('sig Amp');title('N=1')
subplot(3,2,3);plot(0:N-1,ygenerated1_2);xlabel('t/s');ylabel('sig Amp');title('N=2')
subplot(3,2,4);plot(0:N-1,ygenerated1_3);xlabel('t/s');ylabel('sig Amp');title('N=4')
subplot(3,2,5);plot(0:N-1,ygenerated1_4);xlabel('t/s');ylabel('sig Amp');title('N=6')
subplot(3,2,6);plot(0:N-1,ygenerated1_5);xlabel('t/s');ylabel('sig Amp');title('N=8')
figure(2);
subplot(3,2,1);plot(f,fftshift(abs(fft(sig'))));xlabel('frequency/Hz');ylabel('sig Amp');title('original')
subplot(3,2,2);plot(f,fftshift(abs(fft(ygenerated1_1))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=1')
subplot(3,2,3);plot(f,fftshift(abs(fft(ygenerated1_2))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=2')
subplot(3,2,4);plot(f,fftshift(abs(fft(ygenerated1_3))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=4')
subplot(3,2,5);plot(f,fftshift(abs(fft(ygenerated1_4))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=6')
subplot(3,2,6);plot(f,fftshift(abs(fft(ygenerated1_5))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=8')
figure(3);
subplot(3,2,1);plot(w0,20*log10(Pxx0));xlabel('frequency/Hz');ylabel('psd/dB');title('original');
subplot(3,2,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');title('N=1');
subplot(3,2,3);plot(w2,20*log10(Pxx2));xlabel('frequency/Hz');ylabel('psd/dB');title('N=2');
subplot(3,2,4);plot(w4,20*log10(Pxx4));xlabel('frequency/Hz');ylabel('psd/dB');title('N=4');
subplot(3,2,5);plot(w6,20*log10(Pxx6));xlabel('frequency/Hz');ylabel('psd/dB');title('N=6');
subplot(3,2,6);plot(w8,20*log10(Pxx8));xlabel('frequency/Hz');ylabel('psd/dB');title('N=8');