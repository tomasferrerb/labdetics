close all

x0 = 1;          % Parámetros figuras
y0 = 0.5;
width = 7;
height =7.5;

L_paquete = [8 16 32 64 128];
x = [1 2 3 4 5];
x_fec = x + 0.1;

delay = [0.17275 0.11557 0.05831 0.038301 0.027681];
delay_fec = [0.48769 0.20439 0.099892 0.060325 0.067377];
dd = [delay delay_fec];

goodput = [35.5662 56.1636 105.3672 160.4129 221.9559];
goodput_fec = [12.5982 30.0609 61.5067 101.8485 91.1879];
gg = [goodput goodput_fec];

PER = [0 0 0 0 0];
PER_fec = [0 0 0 0 0];
pp = [PER PER_fec];

BER = [0 0 0 0 0];
BER_fec = [0 0 0 0 0];
bb = [BER BER_fec];


f1 = figure();
title('asd')
set(f1,'Units','inches');
set(f1,'Position',[x0 y0 width height]);
f1.PaperPositionMode='auto';
% Delay
subplot(4,1,1)
p = plot(x,delay,'-o');
set(p,'LineWidth',2)
hold on
p = plot(x_fec,delay_fec,'-o');
set(p,'LineWidth',2)
legend('Location','northeast')
legend('Sin FEC','Con FEC')
title('Delay','FontSize',12)
xticks(x)
xticklabels({'8 bits','16 bits','32 bits','64 bits','128 bits'})
ylabel('Tiempo [s]')
ylim([0 max(dd)])
% Goodput
subplot(4,1,2)
p = plot(x,goodput,'-o');
set(p,'LineWidth',2)
hold on
p = plot(x_fec,goodput_fec,'-o');
set(p,'LineWidth',2)
legend('Location','northeast')
legend('Sin FEC','Con FEC')
title('Goodput','FontSize',12)
xticks(x)
xticklabels({'8 bits','16 bits','32 bits','64 bits','128 bits'})
ylabel('TX [kbps]')
ylim([0 max(gg)])
% PER
subplot(4,1,3)
p = plot(x,PER,'-o');
set(p,'LineWidth',2)
hold on
p = plot(x_fec,PER_fec,'-o');
set(p,'LineWidth',2)
legend('Location','northeast')
legend('Sin FEC','Con FEC')
title('PER','FontSize',12)
xticks(x)
xticklabels({'8 bits','16 bits','32 bits','64 bits','128 bits'})
ylim([0 max(pp)+0.1])
% BER
subplot(4,1,4)
p = plot(x,BER,'-o');
set(p,'LineWidth',2)
hold on
p = plot(x_fec,BER_fec,'-o');
set(p,'LineWidth',2)
legend('Location','northeast')
legend('Sin FEC','Con FEC')
title('BER','FontSize',12)
xticks(x)
xticklabels({'8 bits','16 bits','32 bits','64 bits','128 bits'})
ylim([0 max(bb)+0.1])

tituloGlobal = suptitle('    Métricas');
set(tituloGlobal,'FontSize',15,'FontWeight','bold')