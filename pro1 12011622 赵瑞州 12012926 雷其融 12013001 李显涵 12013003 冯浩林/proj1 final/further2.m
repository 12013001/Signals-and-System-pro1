[sig, fs] = audioread('C_01_01.wav');%read the signals
%------------------------Evaluation for the results------------------------
%Initialize matrix corr
corr=(zeros(200,1));
%Get the real part of the Fast Fourier Transform of signals
sf=abs(fft(sig));
%Use for loop to find correlation coefficients for different N
for i=1:200
 corr(i)=corr2(sf,abs(fft(tonevocoder(sig,fs,800,i))));%Remember to set LPF cutoff frequency here
end
%Plot the figure
figure;stem(corr);
title('Correlation due to change of number of bands');
xlabel('N');

s_singular = tonevocoder(sig,fs,800,149);
s_left = tonevocoder(sig,fs,800,148);
s_right = tonevocoder(sig,fs,800,150);
figure;sgtitle('Presentation for the singular point')
subplot(4,1,1);plot(sig);
axis([0,52215,-0.3,0.3]);
title('The original signal');
subplot(4,1,2);plot(s_singular);
axis([0,52215,-0.3,0.3]);
title('The output with N=149, cut-off frequency 800Hz');
subplot(4,1,3);plot(s_left);
axis([0,52215,-1,1]);
title('The output with N=148, cut-off frequency 800Hz');
subplot(4,1,4);plot(s_right);
axis([0,52215,-1,1]);
title('The output with N=150, cut-off frequency 800Hz');

figure;
corr=(zeros(200,1));
sf=abs(fft(sig));
for i=1:200
  corr(i)=corr2(sf,abs(fft(tonevocoder(sig,fs,50,i))));
end
stem(corr);
title('Correlation due to change of number of bands');
xlabel('N');

figure;
corr=(zeros(200,1));
sf=abs(fft(sig));
for i=1:200
  corr(i)=corr2(sf,abs(fft(tonevocoder(sig,fs,100,i))));
end
stem(corr);
title('Correlation due to change of number of bands');
xlabel('N');

figure;
corr=(zeros(200,1));
sf=abs(fft(sig));
for i=1:200
  corr(i)=corr2(sf,abs(fft(tonevocoder(sig,fs,200,i))));
end
stem(corr);
title('Correlation due to change of number of bands');
xlabel('N');

figure;
corr=(zeros(200,1));
sf=abs(fft(sig));
for i=1:200
  corr(i)=corr2(sf,abs(fft(tonevocoder(sig,fs,400,i))));
end
stem(corr);
title('Correlation due to change of number of bands');
xlabel('N');