%Import the audio file
[sig,fs] = audioread('C_01_01.wav');%Choose 01 or 02

%-------------------Task1-------------------
ygenerated1_1 = tonevocoder(sig,fs,50,1);
ygenerated1_2 = tonevocoder(sig,fs,50,2);
ygenerated1_3 = tonevocoder(sig,fs,50,4);
ygenerated1_4 = tonevocoder(sig,fs,50,6);
ygenerated1_5 = tonevocoder(sig,fs,50,8);

%Save as .wav file
audiowrite('C_01_01_N=1_f=50Hz.wav',ygenerated1_1,fs);
audiowrite('C_01_01_N=2_f=50Hz.wav',ygenerated1_2,fs);
audiowrite('C_01_01_N=4_f=50Hz.wav',ygenerated1_3,fs);
audiowrite('C_01_01_N=6_f=50Hz.wav',ygenerated1_4,fs);
audiowrite('C_01_01_N=8_f=50Hz.wav',ygenerated1_5,fs);

%Check the final effects here
%sound(sig,fs);
%sound(ygenerated1_1,fs);
%sound(ygenerated1_2,fs);
%sound(ygenerated1_3,fs);
%sound(ygenerated1_4,fs);
%sound(ygenerated1_5,fs);

%-------------------Task2-------------------
ygenerated2_1 = tonevocoder(sig,fs,20,4);
ygenerated2_2 = tonevocoder(sig,fs,50,4);
ygenerated2_3 = tonevocoder(sig,fs,100,4);
ygenerated2_4 = tonevocoder(sig,fs,400,4);

%Check the final effects here
%sound(sig,fs);
%sound(ygenerated2_1,fs);
%sound(ygenerated2_2,fs);
%sound(ygenerated2_3,fs);
%sound(ygenerated2_4,fs);


%-------------------Task3-------------------
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

%Check the final effects here
% sound(yns,fs);
% sound(ygenerated3_1,fs);
% sound(ygenerated3_2,fs);
% sound(ygenerated3_3,fs);
% sound(ygenerated3_4,fs);
% sound(ygenerated3_5,fs);

%-------------------Task4-------------------
ygenerated4_1 = tonevocoder(yns,fs,20,6);
ygenerated4_2 = tonevocoder(yns,fs,50,6);
ygenerated4_3 = tonevocoder(yns,fs,100,6);
ygenerated4_4 = tonevocoder(yns,fs,400,6);

%Check the final effects here
%sound(s,fs);
% sound(ygenerated4_1,fs);
% sound(ygenerated4_2,fs);
% sound(ygenerated4_3,fs);
% sound(ygenerated4_4,fs);