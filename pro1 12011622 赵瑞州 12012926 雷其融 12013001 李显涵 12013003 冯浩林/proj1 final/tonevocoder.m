function [ygenerated] = tonevocoder(sig,fs,LPF_cutoff_frequency,number_of_bands)
%tonevocoder  Speech synthesis with envelope cue
%    1.Bandpass
%    2.Rectification+LPF = Envelope extraction
%    3.Frequency shift
%    4.Sum & energy normalization

%Set LPF cutoff frequency,依照课件里选择设计4阶的低通滤波器
[blpf,alpf] = butter(4,LPF_cutoff_frequency/(fs/2));

%Devide into N bands
N = number_of_bands; %Set the number of bands
frange = [200,7000];
drange = 1/0.06*log10(frange/165.4+1);%算出200Hz与7000Hz所对应的长度
d = (0:N)*(max(drange)-min(drange))/N+min(drange);%将200Hz和7000Hz所对应的长度均分为N份，算出其间的断点（加上头和尾共N+1个）
f = 165.4*(10.^(0.06*d)-1); %Critical frequencies %根据在长度上所打的断点去确定每一个断点频率的值（N+1个，包括200Hz与7000Hz）
passband = [f(1:N);f(2:N+1)];
bandcenter = mean(passband);%中心频率

%For each frequency band, do bandpass filtering, 每个断点频率间设计带通滤波器
b = zeros(N,9); a = zeros(N,9);%Coefficients of different filters are stored in different rows
y = zeros(length(sig),N);%The results are stored in different column
for i = 1:N
    [b(i,:),a(i,:)] = butter(4,[passband(1,i) passband(2,i)]/(fs/2));
    y(:,i) = filter(b(i,:),a(i,:),sig);%所在频率实现带通滤波器
end

%Full-wave rectification and generate envelope by lowpass filtering
yrectify = abs(y);%整流滤波
envelope = zeros(length(sig),N);
for i = 1:N
    envelope(:,i) = filter(blpf,alpf,yrectify(:,i));%低通滤波器实现语音包络
end

%Generate sinewave and multiply it with the envelope, finally add it all
ygenerated = zeros(length(sig),1);
for i = 1:N
    sinewave = sin(2*pi*bandcenter(i)*[1:length(sig)]/fs);%创建一个频率和中心频率相等的正弦波
    scurrentband = envelope(:,i).*sinewave';%Transpose and use dot product，将创建的正弦波与包络信号相乘
    ygenerated =  ygenerated + scurrentband;%将该频率区间整合出的信号累加到y中，用循环重复N次
end

%Energy normalization,使输出信号能量与输入信号相同
ygenerated = ygenerated/norm(ygenerated)*norm(sig);
end