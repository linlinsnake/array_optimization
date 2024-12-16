clear all;
rmax = 0.08;
r0 = 0.016;
% beta = 0:0.005:1;% 待定参数？？
alpha = 4.2/6 * pi; %待定参数？？
Na = 15;%15个臂
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