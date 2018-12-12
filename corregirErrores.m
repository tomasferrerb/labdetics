function matrix3 = corregirErrores(matrix5)
[row col prof]=size(matrix5); 
matrix3 = zeros(row,col,3);
for i=1:row
    for j=1:col
        px=[matrix5(i,j,1)  matrix5(i,j,2) matrix5(i,j,3) matrix5(i,j,4) matrix5(i,j,5)];
        px_code=gf(px,8);
        px_decode = rsdec(px_code,5,3);
        px=px_decode.x;
        matrix3(i,j,:)=[px(1) px(2) px(3)];
    end
end
end