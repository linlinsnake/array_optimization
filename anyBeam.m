function [ Beam ] = anyBeam(xi,yi,f,lim, ux_set, uy_set)
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
     % Create mesh grids for ux_set and uy_set
    [UX, UY] = meshgrid(ux_set, uy_set);

    % Compute the sum in a vectorized way using broadcasting
    % Broadcast xi and yi to match the UX and UY mesh grid sizes
    XiMatrix = xi(:) * UX(:).';  % Size: [N, nx * ny]
    YiMatrix = yi(:) * UY(:).';  % Size: [N, nx * ny]

    % Sum along the rows (over xi and yi), and then reshape it
    BeamTemp = exp(1j * k * (XiMatrix + YiMatrix));
    Beam = (1 / N) * sum(BeamTemp, 1);  % Sum along the N dimension

    % Reshape Beam to match the [nx, ny] grid
    Beam = reshape(Beam, nx, ny);
	absBeam = abs(Beam);

        Beam = 10*log10(absBeam.^2);
        %Beam = 20*log10(Beam);
Beam(Beam<lim)=lim;
 