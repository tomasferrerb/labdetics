confetings;


%%Abrir imagen para comparar errores 
imgOriginal0 = imread(img);
[rowC,colC,profC] = size(imgOriginal);
imgOriginal = incluirRedundancias(img);
vectorOriginal =img2vector(imgOriginal);
matrizOriginal = vector2packet(vectorOriginal, l_paquete);
matrizOriginal2 = vector2packet(img2vector(imgOriginal0),l_paquete);
paquetes_erroneos=0; 


matriz=[];

%Recibir paquetes 
%Configurar puertos
clc
disp(['Redundancias calculadas L_paquete = ' num2str(l_paquete)])
%%
udpC = udp(ipA,portA,'LocalPort',portC,'Timeout',30);
udpC.InputBufferSize = 1000000;
fopen(udpC);


%Recibir paquetes y ordenar en matriz
count=1;
total_datos=0;
tiempo_final=0;
while 1
    vec=fread(udpC,250,'uint8');
    if vec(1)==0%PRIMER PAQUETE
        tic;
        row=vec(2);
        col=vec(3);
        N=vec(4);
    elseif ~(vec(1)== N)    
        matriz(vec(1),:)=vec;
        if ~(matrizOriginal(vec(1),:)==vec)
            paquetes_erroneos=paquetes_erroneos+1;
        end
        count=count+1;
        total_datos=total_datos+vec(2);
    else
        tiempo_final=toc;
        break
    end
end
fclose(udpC);

disp('Mensajes recibidos por sockets desde A')
%% Metricas y mostrar imagen
clc
disp(['M�tricas L_paquete = ' num2str(l_paquete)])
delay=tiempo_final;
disp(['Delay = ' num2str(delay) '[s]'])
goodput=8*total_datos/tiempo_final*0.6; % por 0.6 por no considerar redundancias
disp(['Goodput = ' num2str(goodput/1000) '[kbps]'])
PER=paquetes_erroneos/(N-1);
disp(['PER = ' num2str(PER)])



vector  = packet2vector(matriz);
image5 = vector2img(vector, row, col);
image = corregirErrores(image5);
BER=row*col*3-sum(sum(sum(imgOriginal(:,:,1:3)==image)));
disp(['BER = ' num2str(BER)])
imshow(uint8(image)); 


%%  Recibir Audio 

%faltan metricas 
tic;
RX; 
delay_audio = toc;
%%
BER_sinFEC=row*col*3-sum(sum(sum(imgOriginal(:,:,1:3)==image_audio)));
BER_sinFEC=BER_sinFEC/(row*col*3);
packetes_audio = vector2packet(img2vector(image_audio),l_paquete);
PER_audio=0;
[packetes largo_packetes]=size(packetes_audio);
for i=1:packetes
   if sum(~(matrizOriginal2(i,:) == packetes_audio(i,:)))>0
     PER_audio=PER_audio+1;
   end
end
PER_audio=PER_audio/packetes;
goodput_audio=row*col*3*8/delay_audio;

%% Mostrar métricas
matriz_FEC=[];
matriz_FEC(:,:,1:3)= image_audio;
matriz_FEC(:,:,4)=image5(:,:,4);
matriz_FEC(:,:,5) = image5(:,:,5);
image_final = corregirErrores(matriz_FEC);

BER_conFEC=row*col*3-sum(sum(sum(imgOriginal(:,:,1:3)==image_final)));
BER_conFEC=BER_conFEC/(row*col*3);
packetes_audio_FEC = vector2packet(img2vector(image_final),l_paquete);
PER_audio_FEC=0;
[packetes largo_packetes]=size(packetes_audio_FEC);
for i=1:packetes
   if sum(~(matrizOriginal2(i,:) == packetes_audio_FEC(i,:)))>0
     PER_audio_FEC=PER_audio_FEC+1;
   end
end
PER_audio_FEC=PER_audio_FEC/packetes;



imshow(uint8(image_final));

subplot(1,3,1)
 imshow(imread(img));
 xlabel('Normal')
 subplot(1,3,2)
 imshow(uint8(image_audio));
 xlabel('Recibida')
subplot(1,3,3);
imshow(uint8(uint8(image_final)));
xlabel('Corregida')

% subplot(1,4,4);
% imshow(uint8(uint8(abs(image_final-image_audio))));
% xlabel('Diferencias')
