function [ Beam ] = anyBeam(xi,yi,f,lim, ux_set, uy_set, type)
    %输出平面阵列的静态方向图
    %xi，yi为阵元的坐标(行向量表示)
    %f为信号频率
    %lim为限制的最小dB(为了方向图好看)
    %ux_set：方向余弦表示(行向量)，范围是[-1,1]。ux_set和uy_set长度要相同。ux_set和uy_set是静态方向图模拟的来波方向。
    %uy_set：方向余弦表示(行向量)，范围是[-1,1]。来波方向向量
    %type：若为“dB”，则用dB表示
    c = 340;    %声音的速度
    lamda = c/f;
    k = 2*pi/lamda;     %|波数|
    N=length(xi);

    nx = size(ux_set,2);    %
    ny = size(uy_set,2);
    Beam = zeros(nx,ny);
    
    for x = 1:nx
        ux = ux_set(x);
        for y = 1:ny
            uy = uy_set(y);
            Beam(x, y) = 1/N*sum(exp(1j*k*(ux * xi + uy * yi)));    %exp(j*r^T*k)=exp(j*|k|*(xi*ux + yi*uy + zi*uz))，因为平面阵uz=0，所以=exp(j*|k|*(xi*ux + yi*uy))
        end 
    end
    %取绝对值并归一化
    %Beam = abs(Beam)/max(max(abs(Beam)));   %max(A)返回行向量，每个元素都是对列求和。max(max(A))返回一个数，是整个矩阵的和。
	absBeam = abs(Beam);
    if strcmpi(type, 'dB')
        Beam = 10*log10(absBeam.^2);
        %Beam = 20*log10(Beam);

        for i = 1:nx
           for j = 1:ny
              if (Beam(i,j)< lim)
                 Beam(i,j) = lim;
              end
           end
        end
    end

end

