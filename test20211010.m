clc;clear;close all;
f=imread('white.png');
whos f                %附加信息
I = rgb2gray(f);
I = I(1:1713,1:1713);
Im=double(I);           %无符号8比特整数uint8[0,255] 变为 双精度浮点(double型) 
%取值为[0,255] 保存后无法查看，为白色 需要归一化
%有些函数支持double型，而不支持uint8的数据类型，所以要转换
%精度问题了，因为uint8进行数据处理的时候，容易造成数据溢出或精度不够。
whos Im

Ima=imresize(Im,[100,100]);
Ima = Ima/max(max(Ima));
k = Ima(:);
m = mean(Ima,'all');
disp(['Ima均值=' num2str(m)]);
v = var(Ima,1,'all');
disp(['Ima方差=' num2str(v)]);
disp(['服从N(',num2str(m),num2str(v),')的高斯分布']);
imhist(Ima,256); hold on
[counts,binLocations] = imhist(Ima);

[fitobject,~]  = fit(binLocations,counts,'gauss1'); %高斯拟合
plot(fitobject),title('imhist');
hold off

figure;
h = histogram(Ima,256);hold on
nbins = h.NumBins;
x=[];
for i = 2:nbins+1
    x(i-1)=0.5*(h.BinEdges(i)+h.BinEdges(i-1));
end
z=h.Values;

x=x';
z=z';
[fitobject,~,~]  = fit(x,z,'gauss1');
plot(fitobject),title('histogram');
hold off

figure;
normplot(k);
