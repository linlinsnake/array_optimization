clear;
clc;
close all;
rmax = 0.08;
r0 = 0.016;
% beta = 0:0.005:1;% 待定参数？？
alpha = 4.2/6 * pi; %待定参数？？
Na = 16;%15个臂
Nm = 8; %每个臂上8个麦克风

[x1, y1] = CreateUnderbrink2( Na,Nm,alpha, rmax, r0);


n = 2:Nm;
r1n=zeros(1,Nm);
r1n(1)=r0;
r1n(2:Nm)=sqrt((2*n-3)/(2*Nm-3))*rmax;
phey1 = log(r1n/r0)/cot(alpha);%+(m-1)/Na*2*pi;

thetaMN = zeros(Nm, Na);
rmn = zeros(Nm, Na);
for m = 1:Na
    thetaMN(:,m)=phey1+(m-1)/Na*2*pi;
    % phey1 = 1/cot(alpha)*log(r1n./r0);%+(m-1)/Na*2*pi;
    rmn(:,m)=r1n;
end

rmn = reshape(rmn, 1, []);
thetaMN = reshape(thetaMN, 1, []);

x=rmn.*cos(thetaMN);
y=rmn.*sin(thetaMN);
figure;
plot(x,y,'o');
hold on
plot(x1,y1,'x');

ux = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
uy = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
f = 3000:1000:40000;
w=f/sum(f);%权重系数
MSL = zeros(2, size(f,2));
BW = zeros(2, size(f,2));


for i = (1:size(f,2))
    Beam = anyBeam(x1, y1, f(i), -30, ux, uy);
    BW(1,i) = search3db(ux, uy, Beam);
    [MSL(1,i),~,~] = findMSL(Beam);
end

figure
plot(f, MSL(1,:),'k', 'LineWidth', 1);

legend('原阵列');
xlabel('频率/Hz')    %y轴方向是列方向，x轴方向是行方向？？？
ylabel('最大旁瓣级/dB');

figure
plot(f, BW(1,:),'k','LineWidth',1);
legend('原阵列');
xlabel('频率/Hz')    %y轴方向是列方向，x轴方向是行方向？？？
ylabel('3dB带宽/°');

