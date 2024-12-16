rmax = 0.09;
r0 = 0.01;
% beta = 0:0.005:1;% 待定参数？？
alpha = 4.1/6 * pi; %待定参数？？
Na = 16;%16个臂
Nm = 8; %每个臂上8个麦克风
[x0,y0]=createMultiDougherty( Na, Nm, alpha, rmax, r0  );


m = 1:Nm;
beta1=(m-1)/(Nm-1);
r1n=r0+beta1*(rmax-r0);
phey1 = 1/cot(alpha)*log(r1n./r0);%+(m-1)/Na*2*pi;
thetaMN = zeros(Nm, Na);
rmn = zeros(Nm, Na);
for m = 1:Na
    thetaMN(:,m)=phey1+(m-1)/Na*2*pi;
    % phey1 = 1/cot(alpha)*log(r1n./r0);%+(m-1)/Na*2*pi;
    rmn(:,m)=r1n;
end
% x1 = r1n.*cos(phey1);
% y1 = r1n.*sin(phey1);
rmn = reshape(rmn, 1, []);
thetaMN = reshape(thetaMN, 1, []);

x=rmn.*cos(thetaMN);
y=rmn.*sin(thetaMN);
plot(x,y,'o');
axis([-0.15 0.15 -0.15 0.15]);
hold on
plot(x0,y0,'x');