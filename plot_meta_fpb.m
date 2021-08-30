clear; clc;


sim('meta_fpb.slx');
subplot(4,1,1)
plot(tout, yout);   
xlabel('Tempo');
ylabel('Amplitude');
filtroPB = designfilt('lowpassiir', 'PassbandFrequency', 1000, 'StopbandFrequency', 1200, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 8000);
s_f = filter(filtroPB,yout);
%fvtool(filtroPB);
%% sinal com ruido frequencia
f = 1000; %Hz
freq_y = fft(yout);
freq_y = freq_y(1:floor(length(freq_y)/2));
n_yout = numel(yout);
eixo_x_yout = (0:n_yout-1).*f/n_yout;
eixo_x_yout = eixo_x_yout(1:floor(length(eixo_x_yout)/2));
subplot(4,1,2)
plot(eixo_x_yout, abs(freq_y));
axis([0 1500 0 200])
%% sinal filtrado tempo
subplot(4,1,3)
plot(tout, s_f);   
xlabel('Tempo');
ylabel('Amplitude');
%% sinal filtrado frequencia
f = 1000; %Hz
freq_s = fft(s_f);
freq_s = freq_s(1:floor(length(freq_s)/2));
subplot(4,1,4)
plot(eixo_x_yout, abs(freq_s));
axis([0 1500 0 200])

%freq_trem = fft(trem_impulso);
% n = 0:Ts:3
% trem_impulso = zeros(1); % impulso unitário
% trem_impulso(rem(n,Ts) == 0) = 1;
% fs = 2*f; %Hz
% Ts = 1/fs;
% figure
% amostragem_tempo = yout * trem_impulso;
% tam = size(amostragem_tempo);
% t = 0:tam-1;
% stem(t, amostragem_tempo);
% xlabel('$t$','Interpreter','LaTex','FontSize',18)
% ylabel('$x[nT_s],x(t)$','Interpreter','LaTex','FontSize',18)
% grid on