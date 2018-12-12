function socket(ip1,ip2. port1, port2, data)
%%Create UDP Object
udpA = udp(ip2,port2,'LocalPort',port1);
udpA.OutputBufferSize = 10000000000
%%Connect to UDP Object
%%Connect to UDP Object
fopen(udpA);

%ENVIAR TODOS LOS PAQUETES 
fwrite(udpA,paquete_ini,'uint8')
for i=1:Npaquetes
    fwrite(udpA, data(i,:) , 'uint8')
    %pause;
end
paquete_end=[Npaquetes+1 row col Npaquetes+1];
fwrite(udpA,paquete_end,'uint8')
fclose(udpA);