%% 模型设置
% 适应度函数的函数句柄
fitnessfcn=@Fun;
% 变量个数
nvars=4;
% 约束条件形式1：下限与上限（若无取空数组[]）
% lb<= X <= ub
lb=[0,0,0,0];
ub=[];

% 约束条件形式2：线性不等式约束（若无取空数组[]）
% A*X <= b 
A = [0    0 1 1
    -1/3  0 0 0
     0 -1/2 0 0
     0    0 0 0];

b = [48 ; 30 ; 30 ; 0];

% 约束条件形式3：线性等式约束（若无取空数组[]）
% Aeq*X == beq
Aeq=[1 1 0 0;0 0 0 0; 0 0 0 0; 0 0 0 0];
beq=[120;0;0;0];





%% 求解器设置
% 最优个体系数paretoFraction
% 种群大小populationsize
% 最大进化代数generations
% 停止代数stallGenLimit
% 适应度函数偏差TolFun
% 函数gaplotpareto：绘制Pareto前沿 
options=optimoptions(@gamultiobj ,'paretoFraction',0.3,'populationsize',200,'generations',300,'stallGenLimit',200,'TolFun',1e-10,'PlotFcns',@gaplotpareto);

%% 主求解
[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options)

%% 结果提取
% 因为gamultiobj是以目标函数分量取极小值为目标，
% 因此在y=Fun(x)里取相反数的目标函数再取相反数画出原始情况
plot(-fval(:,1),fval(:,2),'pr')
xlabel('f_1(x)')
ylabel('f_2(x)')
title('Pareto front')
grid on

