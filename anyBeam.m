function [ Beam ] = anyBeam(xi,yi,f,lim, ux_set, uy_set, type)
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
    Beam = zeros(nx,ny);
    
    for x = 1:nx
        ux = ux_set(x);
        for y = 1:ny
            uy = uy_set(y);
            Beam(x, y) = 1/N*sum(exp(1j*k*(ux * xi + uy * yi)));    %exp(j*r^T*k)=exp(j*|k|*(xi*ux + yi*uy + zi*uz))����Ϊƽ����uz=0������=exp(j*|k|*(xi*ux + yi*uy))
        end 
    end
    %ȡ����ֵ����һ��
    %Beam = abs(Beam)/max(max(abs(Beam)));   %max(A)������������ÿ��Ԫ�ض��Ƕ�����͡�max(max(A))����һ����������������ĺ͡�
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

