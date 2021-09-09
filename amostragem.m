clear; clc;
[xt,fc,phi,t]=sinal(2,20,1000);
filtro = designfilt('lowpassiir', 'PassbandFrequency', 1000, 'StopbandFrequency', 1200, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 8000);
sinal_filtrado = filter(filtro, xt);

figure(2)
plot(t,sinal_filtrado)
title('Sinal Filtrado');
Fs=8000;

figure(3)
y3=fft(sinal_filtrado); grid on;
yaux=fliplr(y3(1,2:end));
X=[yaux y3];
X(1,1:length(X)/4)=0;
X(1,3*length(X)/4:end)=0;
length(X);
omega=0:Fs/length(y3):Fs-(Fs/length(y3));
waux=-fliplr(omega(1,2:end));
w=[waux omega];
length(w);
plot(w,abs(2*X/length(t)));
xlabel('$f$(Hz)','interpreter','latex');
ylabel('Magnitude');
title('Espectro $|X_{c}(j2\pi f)| Sinal Filtrado$','interpreter','latex');
fs = 2200;
trem = square(4400*pi*t);
s_amostrado = trem .* sinal_filtrado;

figure(4)
stem(t, s_amostrado);
title('Sinal Amostrado');

figure(5)
y4=fft(s_amostrado); grid on;
yaux=fliplr(y4(1,2:end));
X=[yaux y4];
X(1,1:length(X)/4)=0;
X(1,3*length(X)/4:end)=0;
length(X);
omega=0:Fs/length(y4):Fs-(Fs/length(y4));
waux=-fliplr(omega(1,2:end));
w=[waux omega];
length(w);
plot(w,abs(2*X/length(t)));
xlabel('$f$(Hz)','interpreter','latex');
ylabel('Magnitude');
title('Espectro $|X_{c}(j2\pi f)|$ Sinal Amostrado','interpreter','latex');

% [yC,tC] = resample(t,s_amostrado,Fs,1,1,'spline');
[yC,tC] = resample(s_amostrado,t,4000);
figure(6)
plot(tC,yC);
grid on
title('Resultado da Conversão D/C');

figure(7);
y4=fft(yC); grid on;
yaux=fliplr(y4(1,2:end));
X=[yaux y4];
X(1,1:length(X)/4)=0;
X(1,3*length(X)/4:end)=0;
length(X);
omega=0:Fs/length(y4):Fs-(Fs/length(y4));
waux=-fliplr(omega(1,2:end));
w=[waux omega];
length(w);
plot(w,abs(2*X/length(tC)));
xlabel('$f$(Hz)','interpreter','latex');
ylabel('Magnitude');
title('Espectro $|X_{c}(j2\pi f)|$ Sinal Continuo','interpreter','latex');

% filtroC = designfilt('lowpassiir', 'PassbandFrequency', 2000, 'StopbandFrequency', 2200, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 8000);
% sinal_filtradoC = filter(filtroC, yC);
% 
% figure(8)
% plot(tC,sinal_filtradoC);
% grid on
% title('Resultado da Conversão D/C Filtrado');
% 
% figure(9);
% y4=fft(sinal_filtradoC); grid on;
% yaux=fliplr(y4(1,2:end));
% X=[yaux y4];
% X(1,1:length(X)/4)=0;
% X(1,3*length(X)/4:end)=0;
% length(X);
% omega=0:Fs/length(y4):Fs-(Fs/length(y4));
% waux=-fliplr(omega(1,2:end));
% w=[waux omega];
% length(w);
% plot(w,abs(2*X/length(tC)));
% xlabel('$f$(Hz)','interpreter','latex');
% ylabel('Magnitude');
% title('Espectro $|X_{c}(j2\pi f)|$ Sinal Continuo Filtrado','interpreter','latex');
