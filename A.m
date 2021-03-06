confetings; 
%%%%%%%%%%%%%ABRIR IMAGEN%%%%%%%%%%%%
imgR= imread(img);
[row,col,prof] = size(imgR);
matrix5 = incluirRedundancias(img)
%%%%%%%%%%%%PASAR MATRIZ RGB A VECTOR%%%%%%%%%%%%%%
vector = img2vector(matrix5);

%%%%%%%%%%%%%CANTIDAD DE PAQUETES%%%%%%%%%%%%%%%%
l = size(vector);
l = l(2);
Npaquetes = floor(l / l_paquete);
if (Npaquetes*l_paquete<l)
    Npaquetes=Npaquetes+1;
end


%%%%ANTES Y DESPUES DE LOS ENVIAR PAQUETES DE DATOS, SE ENVIA UN PAQUETE
%%%%ESPECIAL CON: 
%%%%    DIMENSIONES DE LA IMAGEN
%%%%    CANTIDAD DE PAQUETES

%%%%%% #paquete dimensiones_imagen tiempo
paquete_ini=[0 row col Npaquetes+1];

%%%%%%%%%%%DIVIDIR VECTOR EN N PAQUETES CON ENCABEZADO%%%%%%%%%%%%%%%%%%
%%%%        HEADER                          %%%%PAYLOAD%%%%%%%%%%%%%%
%%%%CANTIDAD DE DATOS%%NUMERO DE PAQUETE%%%%
matriz = vector2packet(vector, l_paquete); %matriz donde cada fila contiene un paquete


%% Create UDP Object
udpAwifi = udp(ipB,portB,'LocalPort',portAwifi);
udpAwifi.OutputBufferSize = 10000000000;
%%Connect to UDP Object
fopen(udpAwifi);

%ENVIAR TODOS LOS PAQUETES 
fwrite(udpAwifi,paquete_ini,'uint8')
for i=1:Npaquetes
    fwrite(udpAwifi, matriz(i,:) , 'uint8')
    %pause;
end
paquete_end=[Npaquetes+1 row col Npaquetes+1];
fwrite(udpAwifi,paquete_end,'uint8')
fclose(udpAwifi);

%%Create UDP Object
udpA = udp(ipC,portC,'LocalPort',portA);
udpA.OutputBufferSize = 10000000000
%%Connect to UDP Object
%%Connect to UDP Object
fopen(udpA);

%ENVIAR TODOS LOS PAQUETES 
fwrite(udpA,paquete_ini,'uint8')
for i=1:Npaquetes
    fwrite(udpA, matriz(i,:) , 'uint8')
    %pause;
end
paquete_end=[Npaquetes+1 row col Npaquetes+1];
fwrite(udpA,paquete_end,'uint8')
fclose(udpA);
%TIEMPO INICIAL EN PRIMER PAQUETE
