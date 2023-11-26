[sig,fs] = audioread('C_01_01.wav');%read the signals
LPF_cutoff_frequency=50;%set the cut-off frequency to 50 Hz
f = fs*(-N/2:N/2-1)/N;
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
ygenerated3_1 = tonevocoder(yns,fs,50,2);
ygenerated3_2 = tonevocoder(yns,fs,50,4);
ygenerated3_3 = tonevocoder(yns,fs,50,6);
ygenerated3_4 = tonevocoder(yns,fs,50,8);
ygenerated3_5 = tonevocoder(yns,fs,50,16);

%% To get psd
[Pxx0,w0] = pwelch(yns,[],[],512,fs);
[Pxx1,w1] = pwelch(ygenerated3_1,[],[],512,fs);
[Pxx2,w2] = pwelch(ygenerated3_2,[],[],512,fs);
[Pxx3,w3] = pwelch(ygenerated3_3,[],[],512,fs);
[Pxx4,w4] = pwelch(ygenerated3_4,[],[],512,fs);
[Pxx5,w5] = pwelch(ygenerated3_5,[],[],512,fs);

%% plot    
figure(1);
subplot(3,2,1);plot(0:N-1,yns);xlabel('t/s');ylabel('sig Amp');title('noisy signal')
subplot(3,2,2);plot(0:N-1,ygenerated3_1);xlabel('t/s');ylabel('sig Amp');title('N=2')
subplot(3,2,3);plot(0:N-1,ygenerated3_2);xlabel('t/s');ylabel('sig Amp');title('N=4')
subplot(3,2,4);plot(0:N-1,ygenerated3_3);xlabel('t/s');ylabel('sig Amp');title('N=6')
subplot(3,2,5);plot(0:N-1,ygenerated3_4);xlabel('t/s');ylabel('sig Amp');title('N=8')
subplot(3,2,6);plot(0:N-1,ygenerated3_5);xlabel('t/s');ylabel('sig Amp');title('N=16')
figure(2);
subplot(3,2,1);plot(f,abs(fftshift(fft(yns'))));xlabel('frequency/Hz');ylabel('sig Amp');title('noisy signal')
subplot(3,2,2);plot(f,fftshift(abs(fft(ygenerated3_1))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=2')
subplot(3,2,3);plot(f,fftshift(abs(fft(ygenerated3_2))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=4')
subplot(3,2,4);plot(f,fftshift(abs(fft(ygenerated3_3))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=6')
subplot(3,2,5);plot(f,fftshift(abs(fft(ygenerated3_4))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=8')
subplot(3,2,6);plot(f,fftshift(abs(fft(ygenerated3_5))));xlabel('frequency/Hz');ylabel('sig Amp');title('N=16')
figure(3);
subplot(3,2,1);plot(w0,20*log10(Pxx0));xlabel('frequency/Hz');ylabel('psd/dB');title('noisy signal');
subplot(3,2,2);plot(w1,20*log10(Pxx1));xlabel('frequency/Hz');ylabel('psd/dB');title('N=2');
subplot(3,2,3);plot(w2,20*log10(Pxx2));xlabel('frequency/Hz');ylabel('psd/dB');title('N=4');
subplot(3,2,4);plot(w3,20*log10(Pxx3));xlabel('frequency/Hz');ylabel('psd/dB');title('N=6');
subplot(3,2,5);plot(w4,20*log10(Pxx4));xlabel('frequency/Hz');ylabel('psd/dB');title('N=8');
subplot(3,2,6);plot(w5,20*log10(Pxx5));xlabel('frequency/Hz');ylabel('psd/dB');title('N=16');