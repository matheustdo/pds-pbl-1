clear all; close all; clc
%% dados do sinal
f = 8000; % Frequ�ncia entrada em Hz
[xt,fc,phi,t] = sinal(2,10,3000);

%% Etapa 1 => Filtro de Entrada
filtro = designfilt('lowpassiir', 'PassbandFrequency', 1000, 'StopbandFrequency', 1500, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', f);
sinal_filtrado = filter(filtro, xt);

%% Etapa 2 => Amostragem
fs = 2000; % Frequ�ncia de amostragem em Hz
ffc = f/fs; % Pega o quanto fs � menor que f

Ts = 1/fs;
N = length(t)/ffc; % A quantidade de amostras � 1/fcc menor do que o tamanho de amostras iniciais
n = [0 : 1 : N-1];
t_amostrado = [0 : Ts : n(N)*Ts];
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
title('Espectro $|X(j2\pi f)|$ sem o filtro','interpreter','latex');

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
title('Espectro $|X(j2\pi f)|$ com o filtro','interpreter','latex');

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
title('Espectro $|X_{s}(j2\pi f)|$','interpreter','latex');