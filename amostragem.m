clear; clc;
clear all;
close all;
[xt,fc,phi,t]=sinal(2,10,4000);
filtro = designfilt('lowpassiir', 'PassbandFrequency', 1000, 'StopbandFrequency', 1500, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 8000);
sinal_filtrado = filter(filtro, xt);
sinal_filtrado = 3*sinal_filtrado;
figure(2)
subplot(2,1,1);
plot(t,sinal_filtrado)
title('Sinal Filtrado');
Fs=8000;

subplot(2,1,2);
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
title('Espectro Sinal Filtrado');

trem = square(32000*pi*t);
s_amostrado = trem .* sinal_filtrado;


figure(3)
subplot(2,1,1);
plot(t, sinal_filtrado, 'r');
hold on;
stem(t, s_amostrado, 'filled','MarkerSize',3);
title('Sinal Amostrado');
xlabel('Tempo(s)','interpreter','latex');
ylabel('Amplitude');
legend('Sinal Contínuo', 'Sinal Amostrado');

subplot(2,1,2);
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
title('Espectro Sinal Amostrado');

% 4000pi = 2pif, logo f = 2000
fs = 16000;
Ts = fs*t;
sinal_discreto = s_amostrado;
n = 0:2:Ts(length(Ts))+1;

figure(4)
subplot(2,1,1);
stem(n,sinal_discreto);
title('Sinal Discreto');
xlabel('n','interpreter','latex');
ylabel('x[n]','interpreter','latex');

subplot(2,1,2);
y4=fft(sinal_discreto); grid on;
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
title('Espectro Sinal Discreto');

ft = 16000;
tt = Ts./ft;
sinal_continuo = sinal_discreto;
figure(5)
subplot(2,1,1);
plot(tt,sinal_continuo);
title('Sinal Contínuo Y');
xlabel('Tempo(s)','interpreter','latex');
ylabel('$y_{r}(t)$','interpreter','latex');

subplot(2,1,2);
y4=fft(sinal_continuo); grid on;
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
title('Espectro Sinal Contínuo');

% title('Comparação da amostragem entre Sinal Amostrado e Sinal Contínuo');
% subplot(2,1,2);
% stem(0:300,s_amostrado(1:301),'filled','MarkerSize',3)
%grid on
% xlabel('Sample Number')
% ylabel('Original')
% subplot(2,1,2)
% stem(0:150,yC(1:151),'filled','MarkerSize',3)
% grid on
% xlabel('Sample Number')
% ylabel('Interpolated')
% grid on

filtro = designfilt('lowpassiir', 'PassbandFrequency', 1000, 'StopbandFrequency', 1200, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 8000);
sinal_filtrado_yC = filter(filtro, sinal_continuo);

figure(6)
subplot(2,1,1);
plot(t,sinal_filtrado_yC)
title('Sinal Filtrado');
xlabel('Tempo(s)','interpreter','latex');
ylabel('Amplitude');

subplot(2,1,2);
y3=fft(sinal_filtrado_yC); grid on;
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
title('Espectro Sinal Convertido Y');

figure(7)
plot(t,sinal_filtrado);
hold on;
plot(tt,sinal_continuo);
title('Comparação dos sinais de entrada e reconstruído');
legend('Sinal de Entrada Filtrado', 'Sinal de Saída Filtrado');
xlabel('Tempo(s)','interpreter','latex');
ylabel('Amplitude');

% sound(sinal_filtrado,Fs);
% pause(5);
% sound(sinal_continuo,Fs);

