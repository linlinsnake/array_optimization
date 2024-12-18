function [ Beam ] = anyBeam(xi,yi,f,lim, ux_set, uy_set)
    %���ƽ�����еľ�̬����ͼ
    %xi��yiΪ��Ԫ������(��������ʾ)
    %fΪ�ź�Ƶ��
    %limΪ���Ƶ���СdB(Ϊ�˷���ͼ�ÿ�)
    %ux_set���������ұ�ʾ(������)����Χ��[-1,1]��ux_set��uy_set����Ҫ��ͬ��ux_set��uy_set�Ǿ�̬����ͼģ�����������
    %uy_set���������ұ�ʾ(������)����Χ��[-1,1]��������������
    %type����Ϊ��dB��������dB��ʾ
    c = 340;    %�������ٶ�
    lamda = c/f;
    k = 2*pi/lamda;     %|����|
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
 