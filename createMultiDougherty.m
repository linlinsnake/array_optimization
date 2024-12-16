function [ x, y ] = createMultiDougherty( Na, Nm, v, rmax, r0  )
% 构建多臂螺旋阵列，最小半径r0，最大半径rmax，螺旋切线与半径间的夹角v，
% 每条臂上阵元数量Nm，悬臂数量Na
%   此处显示详细说明

m = (1:Na);
n = (1:Nm);

lmax = r0*sqrt(1+cot(v)^2)/cot(v)*(rmax/r0-1);
l = (n-1)/(Nm-1)*lmax;
theta1 = 1/cot(v)*log(1+cot(v)*l/r0/sqrt(1+cot(v)^2));
r1 = r0*exp(cot(v)*theta1);
%生成所有臂
r = zeros(Nm, Na);
theta = zeros(Nm, Na);
for m = 1:Na
    theta(:,m) = theta1 + (m-1)*2*pi/Na;
    r(:,m) = r0*exp(cot(v)*theta1);
end
r = reshape(r, 1, []);
theta = reshape(theta, 1, []);
%画阵列图
x = r.*cos(theta);
y = r.*sin(theta);

end

