function [] = graphmaker(sig,fs,LPF_cutoff_frequency,number_of_bands,noise)
%Make graphs of tonevocoder  Speech synthesis with envelope cue

%Set LPF cutoff frequency
[blpf,alpf] = butter(4,LPF_cutoff_frequency/(fs/2));

%Divide into N bands
N = number_of_bands; %Set the number of bands
frange = [200,7000];
drange = 1/0.06*log10(frange/165.4+1);
d = (0:N)*(max(drange)-min(drange))/N+min(drange);
f = 165.4*(10.^(0.06*d)-1); %Critical frequencies
passband = [f(1:N);f(2:N+1)];
bandcenter = mean(passband);

%For each frequency band, do bandpass filtering
b = zeros(N,9); a = zeros(N,9);%Coefficients of different filters are stored in different rows
y = zeros(length(sig),N);%The results are stored in different column

for i = 1:N
    [b(i,:),a(i,:)] = butter(4,[passband(1,i) passband(2,i)]/(fs/2));
    y(:,i) = filter(b(i,:),a(i,:),sig);
    subplot(N,3,(3*i-2));
    plot( y(:,i) );xlabel('Samples');ylabel('Amp');
end

%Full-wave rectification and generate envelope by lowpass filtering
yrectify = abs(y);
envelope = zeros(length(sig),N);
for i = 1:N
    envelope(:,i) = filter(blpf,alpf,yrectify(:,i));
    subplot(N,3,(3*i-1));
    plot(envelope(:,i) );xlabel('Samples');ylabel('Env');axis([0,length(envelope(:,i)),0,max(envelope(:,i))]);
end

%Generate figures of bands of the output signal
for i = 1:N
    sinewave = sin(2*pi*bandcenter(i)*[1:length(sig)]/fs);
    scurrentband = envelope(:,i).*sinewave';%Transpose and use dot product
    subplot(N,3,(3*i));
    plot(scurrentband);xlabel('Samples');ylabel('BOS');
end

%Make title
if noise==1
    if number_of_bands==1
    sgtitle(['Figures with ' ,num2str(number_of_bands), ' band and LPF cut-off frequency ',num2str(LPF_cutoff_frequency),'Hz with noise']);
else
    sgtitle(['Figures with ' ,num2str(number_of_bands), ' bands and LPF cut-off frequency ',num2str(LPF_cutoff_frequency),'Hz with noise']);
    end
else
    if number_of_bands==1
    sgtitle(['Figures with ' ,num2str(number_of_bands), ' band and LPF cut-off frequency ',num2str(LPF_cutoff_frequency),'Hz']);
else
    sgtitle(['Figures with ' ,num2str(number_of_bands), ' bands and LPF cut-off frequency ',num2str(LPF_cutoff_frequency),'Hz']);
    end
end

end