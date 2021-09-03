clear; clc;
[xt,fc,phi,t]=sinal(2,20,1000);
filtro = designfilt('lowpassiir', 'PassbandFrequency', 1, 'StopbandFrequency', 1000, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 8000);
sinal_filtrado = filter(filtro, xt);

figure
plot(t,sinal_filtrado)
title('sinal filtrado');
Fs=8000;

figure
y3=fft(sinal_filtrado); grid on;
length(y3)
w=0:Fs/length(y3):Fs-(Fs/length(y3));
length(w)
plot(w,abs(2*y3/length(t)));
xlabel('f(Hz)');
ylabel('Magnitude');
title('|X(j2\pif)| Espectro sinal filtrado');
fs = 2200;
trem = square(4000*pi*t)
s_amostrado = trem .* sinal_filtrado;

figure
stem(t, s_amostrado);
title('sinal amostrado');

figure
y4=fft(s_amostrado); grid on;
length(y4);
w=0:Fs/length(y4):Fs-(Fs/length(y4));
length(w);
plot(w,abs(2*y4/length(t)));
xlabel('f(Hz)');
ylabel('Magnitude');
title('|X(j2\pif)| Espectro sinal amostrado');
