%% 模型设置
% 适应度函数的函数句柄
fitnessfcn=@Fun;
% 变量个数
nvars=9;
% 约束条件形式1：下限与上限（若无取空数组[]）
% lb<= X <= ub
lb=[0.014  ,0.0212 ,0.0354, 0.0466 , 0.0567 , 0.0656 , 0.0736, 0.0800,1e-5];
ub=[0.018 ,0.0304 ,0.0416 , 0.0527 , 0.0616 , 0.0696 , 0.0760, 0.08,2*pi];

% 约束条件形式2：线性不等式约束（若无取空数组[]）
% A*X <= b 
A = [];

b = [];

% 约束条件形式3：线性等式约束（若无取空数组[]）
% Aeq*X == beq
Aeq=[];
beq=[];

%种群大小
N=50;
%种群初始化随机解
initialPopulation = repmat(lb, N, 1) + rand(N, nvars) .* (repmat(ub - lb, N, 1));
knownSolutions = [0.016 ,0.0222 ,0.0384 , 0.0496 , 0.0587 , 0.0666 , 0.0736, 0.0800,4.2*pi/16]; % 已知解
initialPopulation(1:size(knownSolutions, 1), :) = knownSolutions;

%% 求解器设置
% 最优个体系数paretoFraction
% 种群大小populationsize
% 最大进化代数generations
% 停止代数stallGenLimit
% 适应度函数偏差TolFun
% 函数gaplotpareto：绘制Pareto前沿 
options=optimoptions(@gamultiobj ,'paretoFraction',0.32,'populationsize',N,'generations',200,'stallGenLimit',100,'InitialPopulationMatrix',initialPopulation,'TolFun',1e-9,'PlotFcns',@gaplotpareto);

%% 主求解
[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options);

%% 结果提取
% 因为gamultiobj是以目标函数分量取极小值为目标，

   Na = 16;%15个臂
    Nm = 8; %每个臂上8个麦克风
    r0=x(2,1);
    alpha = x(9);

    [x0, y0] = CreateUnderbrink2( Na,Nm,alpha, 0.08, 0.016);


	phey1 = log(x(1,1:8)/r0)/cot(alpha);%+(m-1)/Na*2*pi;
thetaMN = zeros(Nm, Na);
rmn = zeros(Nm, Na);
for m = 1:Na
    thetaMN(:,m)=phey1+(m-1)/Na*2*pi;
    rmn(:,m)=x(1,1:8);
end

rmn = reshape(rmn, 1, []);
thetaMN = reshape(thetaMN, 1, []);

x1=rmn.*cos(thetaMN);
y1=rmn.*sin(thetaMN);

ux = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
uy = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
f = 3000:1000:50000;
w=f/sum(f);%权重系数
MSL = zeros(2, size(f,2));
BW = zeros(2, size(f,2));

for i = (1:size(f,2))
    Beam = anyBeam(x0, y0, f(i), -30, ux, uy);
    BW(1,i) = search3db(ux, uy, Beam);
    [MSL(1,i),~,~] = findMSL(Beam);

    Beam = anyBeam(x1, y1, f(i), -30, ux, uy);
    BW(2,i) = search3db(ux, uy, Beam, f(i));
    [MSL(2,i),~,~] = findMSL(ux, uy);
end
figure
plot(f, MSL(1,:),'k', 'LineWidth', 1);
hold on;
plot(f, MSL(2,:),'r', 'LineWidth', 1);

legend('原阵列', '优化阵列');
xlabel('频率/Hz')    %y轴方向是列方向，x轴方向是行方向？？？
ylabel('最大旁瓣级/dB');

figure
plot(f, BW(1,:),'k', f, BW(2,:),'r','LineWidth',1);
axis([-inf inf 0 25]);
legend('原阵列', '优化阵列');
xlabel('频率/Hz')    %y轴方向是列方向，x轴方向是行方向？？？
ylabel('3dB带宽/°');

figure;
plot(fval(:,1),fval(:,2),'pr')
xlabel('f_1(x)')
ylabel('f_2(x)')
title('Pareto front')
grid on

