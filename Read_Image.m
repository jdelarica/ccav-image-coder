function [img] = Read_Image(name)
    n = 256;
    m = 256;
    im = fopen(name);
    img=fread(im,[n,m]);
    img=img';
    img = uint8(img);
end
