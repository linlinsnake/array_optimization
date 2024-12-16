function [fitness] = underbrink_cost(rn,dim,Na,v)


r0=rn(1);
r = zeros(dim, Na);
%r(Nm,:)=rmax;
for n=1:dim
    r(n,:)=rn(n);
end
theta = zeros(dim, Na);
for m = 1:Na
    theta(:,m) = log(r(:,m)/r0)/cot(v)+2*pi*(m-1)/Na;
   
end
r = reshape(r, 1, []);
theta = reshape(theta, 1, []);
%画阵列图
x = r.*cos(theta);
y = r.*sin(theta);
ux = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
uy = -1/sqrt(2):sqrt(2)/200:1/sqrt(2);
f = 5000:500:50000;

for i = (1:size(f,2))
    Beam = anyBeam(x, y, f(i), -30, ux, uy, 'dB');
    BW = search3db(ux, uy, Beam, f(i));
    [MSL,~,~] = findMSL(ux, uy, Beam);
end
fitness=mean(BW)+2*mean(MSL);
