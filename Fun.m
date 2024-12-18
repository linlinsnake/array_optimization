function y=Fun(x)
	% y是目标函数向量。有几个目标函数y就有多少个维度（数组y的长度）
	% 因为gamultiobj是以目标函数分量取极小值为目标，
	% 因此有些取极大值的目标函数注意取相反数
    Na = 16;%15个臂
    Nm = 8; %每个臂上8个麦克风
    r0=x(1);
    alpha = x(9);
	phey1 = log(x(1:8)/r0)/cot(alpha);%+(m-1)/Na*2*pi;
thetaMN = zeros(Nm, Na);
rmn = zeros(Nm, Na);
for m = 1:Na
    thetaMN(:,m)=phey1+(m-1)/Na*2*pi;
    rmn(:,m)=x(1:8);
end

rmn = reshape(rmn, 1, []);
thetaMN = reshape(thetaMN, 1, []);

x1=rmn.*cos(thetaMN);
y1=rmn.*sin(thetaMN);
[xt, yt] = createSingleCircle(0.012, 8);
x1 = [x1 xt];
y1 = [y1 yt];
ux = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
uy = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
f = 3000:1000:40000;
w=f/sum(f);%权重系数
MSL = zeros(1, size(f,2));
BW = zeros(1, size(f,2));
for i = (1:size(f,2))
    Beam = anyBeam(x1, y1, f(i), -30, ux, uy, 'dB');
    BW(1,i) = search3db(ux, uy, Beam, f(i));
    [MSL(1,i),~,~] = findMSL(ux, uy, Beam);
end
Average_MSL=sum(MSL.*w); %加权平均,越高频率越关注
Average_3DB=mean(BW);
y(1)=Average_MSL;
y(2)=Average_3DB;
end
