function [ x, y ] = CreateUnderbrink2( Na, Nm, v, rmax, r0 )
% 构建多臂螺旋阵列，最小半径r0，最大半径rmax，螺旋切线与半径间的夹角v，
% 每条臂上阵元数量Nm，悬臂数量Na
%阵列区域被划分为Nm-1个面积相等的圆环

m = (1:Na);
n = (1:Nm);
%划分成l=Nm-1个相等圆环；
r = zeros(Nm, Na);
%r(Nm,:)=rmax;
r(1,:)=r0;
for n=2:Nm
    r(n,:)=sqrt((2*n-3)/(2*Nm-3))*rmax;
end
theta = zeros(Nm, Na);
for m = 1:Na
    theta(:,m) = log(r(:,m)/r0)/cot(v)+2*pi*(m-1)/Na;
   
end
r = reshape(r, 1, []);
theta = reshape(theta, 1, []);
%画阵列图
x = r.*cos(theta);
y = r.*sin(theta);

