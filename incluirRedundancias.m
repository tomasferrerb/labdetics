function img_red = incluirRedundancias(img)
    % Entra una imagen
    % Sale una hipermatriz de 3D, con 5 elementos en
    % la tercera dimensión
    imgR = imread(img);
    [row,col,~] = size(imgR);
    R1 = zeros(row,col);
    R2 = R1;
    for i = 1:row
        for j = 1:col
            px=[imgR(i,j,1) imgR(i,j,2) imgR(i,j,3)];
            px_gf=gf(px,8);
            px_code=rsenc(px_gf,5,3);
            px_code_decimal = px_code.x;
            R1(i,j)=px_code_decimal(4);
            R2(i,j)=px_code_decimal(5);
        end
    end
    img_red1 = cat(3,imgR,R1);
    img_red = cat(3,img_red1,R2);
end