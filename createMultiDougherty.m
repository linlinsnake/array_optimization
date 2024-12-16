function [ x, y ] = createMultiDougherty( Na, Nm, v, rmax, r0  )
% ��������������У���С�뾶r0�����뾶rmax������������뾶��ļн�v��
% ÿ��������Ԫ����Nm����������Na
%   �˴���ʾ��ϸ˵��

m = (1:Na);
n = (1:Nm);

lmax = r0*sqrt(1+cot(v)^2)/cot(v)*(rmax/r0-1);
l = (n-1)/(Nm-1)*lmax;
theta1 = 1/cot(v)*log(1+cot(v)*l/r0/sqrt(1+cot(v)^2));
r1 = r0*exp(cot(v)*theta1);
%�������б�
r = zeros(Nm, Na);
theta = zeros(Nm, Na);
for m = 1:Na
    theta(:,m) = theta1 + (m-1)*2*pi/Na;
    r(:,m) = r0*exp(cot(v)*theta1);
end
r = reshape(r, 1, []);
theta = reshape(theta, 1, []);
%������ͼ
x = r.*cos(theta);
y = r.*sin(theta);

end

