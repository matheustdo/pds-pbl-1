clear all; close all; clc
%% dados do sinal
[y_audio, f] = audioread('audio_entrada.wav');
xt = y_audio(:,1)';
t = linspace(0,length(xt)/f,length(xt));

%% Etapa 1 => Filtro de Entrada
filtro = designfilt('lowpassiir', 'PassbandFrequency', 1000, 'StopbandFrequency', 1500, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', f);
sinal_filtrado = filter(filtro, xt);

%% Etapa 2 => Amostragem
fs = 4000; % Frequência de amostragem em Hz
ffc = f/fs; % Pega o quanto fs é menor que f

Ts = 1/fs;
N = length(t)/ffc; % A quantidade de amostras é 1/fcc menor do que o tamanho de amostras iniciais
n = 0 : 1 : N-1;
t_amostrado = 0 : Ts : n(N)*Ts;
sinal_amostrado = zeros(1);
k = 0;

for i = 1 : 1 : N
   sinal_amostrado(i) = sinal_filtrado(k + 1);
   k = k + ffc;
end

%% Faz o plot dos resultados

% Figura 1: x(t) filtrado
figure(1)
subplot(3,1,1)
plot(t, sinal_filtrado);
xlabel('$t$','Interpreter','LaTex','FontSize',18)
ylabel('$x(t)$','Interpreter','LaTex','FontSize',18)
title('x(t) filtrado');

% Figura 1: x[t] amostrado
subplot(3,1,2)
stem(n, sinal_amostrado); 
xlabel('$n$','Interpreter','LaTex','FontSize',18)
ylabel('$x[n]$','Interpreter','LaTex','FontSize',18)
title('x[t] amostrado');

% Figura 1: x(t) e x[t]
subplot(3,1,3)
plot(t, sinal_filtrado);
hold;
plot(t_amostrado, sinal_amostrado, 'o');
xlabel('$t$','Interpreter','LaTex','FontSize',18)
ylabel('$x[nT_s],x(t)$','Interpreter','LaTex','FontSize',18)
title('x(t) e x[n]');

% Figura 2: Espectro de x(t) sem o filtro
figure(2)
subplot(3,1,1);
y=fft(xt); grid on;
yaux=fliplr(y(1,2:end));
X=[yaux y];
X(1,1:length(X)/4)=0;
X(1,3*length(X)/4:end)=0;
length(X);
omega=0:f/length(y):f-(f/length(y));
waux=-fliplr(omega(1,2:end));
w=[waux omega];
length(w);
plot(w,abs(2*X/length(t)));
xlabel('$f$(Hz)','interpreter','latex');
ylabel('Magnitude');

% Figura 2: Espectro de x(t) com o filtro
figure(2)
subplot(3,1,2);
y=fft(sinal_filtrado); grid on;
yaux=fliplr(y(1,2:end));
X=[yaux y];
X(1,1:length(X)/4)=0;
X(1,3*length(X)/4:end)=0;
length(X);
omega=0:f/length(y):f-(f/length(y));
waux=-fliplr(omega(1,2:end));
w=[waux omega];
length(w);
plot(w,abs(2*X/length(t)));
xlabel('$f$(Hz)','interpreter','latex');
ylabel('Magnitude');

% Figura 2: Espectro de x[n]
figure(2)
subplot(3,1,3);
y=fft(sinal_amostrado); grid on;
yaux=fliplr(y(1,2:end));
X=[yaux y];
X(1,1:length(X)/4)=0;
X(1,3*length(X)/4:end)=0;
length(X);
omega=0:fs/length(y):fs-(fs/length(y));
waux=-fliplr(omega(1,2:end));
w=[waux omega];
length(w);
plot(w,abs(2*X/length(t)));
xlabel('$f$(Hz)','interpreter','latex');
ylabel('Magnitude');

%% Mudança da taxa de amostragem

M = 2
sinal_subamostrado = downsample(sinal_amostrado,M);
t_subamostrado = downsample(t_amostrado,M);
Td = M*Ts;
fd = 1/Td;
Nd = N/M;
nd = 0 : 1 : Nd-1;
figure(3)
plot(t_amostrado, sinal_amostrado, t_subamostrado, sinal_subamostrado);
xlabel('$t_d$','Interpreter','LaTex','FontSize',18);
ylabel('$y(nT), y(nT_d)$','Interpreter','LaTex','FontSize',18);


%% Reconstrução

sinal_reconstruido = sinal_subamostrado*sinc(fd*(ones(length(nd),1)*t-(nd*Td)'*ones(1, length(t))));

figure(3)
subplot(3,1,1);
plot(t, sinal_filtrado);
xlabel('$t$','Interpreter','LaTex','FontSize',18);
ylabel('$x_c(t)$','Interpreter','LaTex','FontSize',18);

subplot(3,1,2);
plot(t, sinal_reconstruido);
xlabel('$t$','Interpreter','LaTex','FontSize',18);
ylabel('$x_r(t)$','Interpreter','LaTex','FontSize',18);

subplot(3,1,3);
plot(t, sinal_filtrado);
hold;
plot(t, sinal_reconstruido);
xlabel('$t$','Interpreter','LaTex','FontSize',18)
ylabel('$x_r(t),x_c(t)$','Interpreter','LaTex','FontSize',18)

plot(t, sinal_reconstruido);

audiowrite('audio_reconstruido.wav', sinal_reconstruido, f);
sound(y_audio, f);
pause(length(xt)/f);
pause(2);
sound(sinal_reconstruido, f);
