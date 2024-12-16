function [ BW ] = search3db( ux, uy, Beam, f )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%   搜索-3db带宽

c = 340;
lambda = c/f;
%获取最大值坐标
[maxBeam,maxBeamIndex] = max(Beam(:));
%[maxBeamYIndex,maxBeamXIndex] = ind2sub(size(Beam), maxBeamIndex);
[maxBeamXIndex,maxBeamYIndex] = ind2sub(size(Beam), maxBeamIndex);
%搜素3db带宽
left = maxBeamXIndex;
while left>1 
    if Beam(left,maxBeamYIndex)<=maxBeam-3
        break;
    end
    left = left - 1;
end
left = abs(ux(left)-ux(maxBeamXIndex));

right = maxBeamXIndex;
while right<size(Beam,1)
    if Beam(right,maxBeamYIndex)<=maxBeam-3
        break;
    end
    right = right + 1;
end
right = abs(ux(right)-ux(maxBeamXIndex));

up = maxBeamYIndex;
while up<size(Beam,2)
    if Beam(maxBeamXIndex,up)<=maxBeam-3
        break;
    end
    up = up + 1;
end
up = abs(uy(up)-uy(maxBeamYIndex));

down = maxBeamYIndex;
while down>1
    if Beam(maxBeamXIndex,down)<=maxBeam-3
        %down = abs(down-maxBeamYIndex);
        break;
    end
    down = down - 1;
end
down = abs(uy(down)-uy(maxBeamYIndex));

kp = max([right left up down]);
%BW = 2/lambda*asin(kp)
BW = 2*asind(kp);
end

