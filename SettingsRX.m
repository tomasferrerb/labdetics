fs=40e3; % sampleo

l_paquete=128;

header_f = 0.3; % delta tiempo de duracion del header 

info_size_f = 0.15; % delta tiempo por pixel 
info_pixel_f = 0.175; % 0.35

head_dt = 0:1/fs:header_f; % delta tiempo de duracion del header 
pixel_dt = 0:1/fs:info_pixel_f; % aca, en frecs

Rf = 4000; %fbase del roja
Gf = 8000; %fbase del verde
Bf = 12000;% fbase del azul
Tf = 14000; % fbase del texto

header1=2000;% las tres frecs del header 
header2=1500;
header3=1000;

ancho=3000;
alto=1500;

len= 500;
delta=200;

dif = 100; % diferencia entre cada valor del pixel 
img='pin.png';

p2f = @(px, b, d) px*d + b;
f2p = @(f, bf, d) round((f-bf)/d);

ttl1 = 3100;
ttl2 = 3400;
ttl3 = 3700;
ttl4 = 4100;
s1=4250;
s2=4500;
s3=4750;
s4=5000;

ipA='192.168.100.25';
ipB='192.168.100.24';
ipC='192.168.100.22';
portA= 9090;
portB=9091;
portC=9092;