function [ BW ] = search3db( ux, uy, Beam)
%   搜索-3db带宽
% Beam=-Beam;
% c = 340;
% lambda = c/f;
%获取最大值坐标
% [maxBeam,maxBeamIndex] = max(Beam(:));
lenY=size(Beam,2);
[~,maxBeamIndex] = max(Beam(:));
%[maxBeamYIndex,maxBeamXIndex] = ind2sub(size(Beam), maxBeamIndex);
[maxBeamXIndex,maxBeamYIndex] = ind2sub(size(Beam), maxBeamIndex);
%搜素3db带宽
% left = maxBeamXIndex;

% 
% while left>1
%     if Beam(left,maxBeamYIndex)<=maxBeam-3
%         break;
%     end
%     left = left - 1;
% end
% % [left , cutoff_left]
% % left = abs(ux(left)-ux(maxBeamXIndex));
% 
% right = maxBeamXIndex;
% while right<size(Beam,1)
%     if Beam(right,maxBeamYIndex)<=maxBeam-3
%         break;
%     end
%     right = right + 1;
% end
% % [left , cutoff_left,right, cutoff_right]
% % right = abs(ux(right)-ux(maxBeamXIndex));
% % left = abs(ux(left)-ux(maxBeamXIndex));
% up = maxBeamYIndex;
% while up<size(Beam,2)
%     if Beam(maxBeamXIndex,up)<=maxBeam-3
%         break;
%     end
%     up = up + 1;
% end
% % up - cutoff_up
% % up = abs(uy(up)-uy(maxBeamYIndex));
% 
% down = maxBeamYIndex;
% while down>1
%     if Beam(maxBeamXIndex,down)<=maxBeam-3
%         %down = abs(down-maxBeamYIndex);
%         break;
%     end
%     down = down - 1;
% end
% cut_off = maxBeam-3;
Beam(Beam<=-3)=0;
[~,cutoff_left]=min(Beam(1:maxBeamXIndex,maxBeamYIndex));
cutoff_left = cutoff_left-1;
cutoff_left(cutoff_left<1)=1;

[~,cutoff_right]=min(Beam(maxBeamXIndex:end,maxBeamYIndex));
cutoff_right = maxBeamXIndex +cutoff_right;
cutoff_right(cutoff_right>lenY)=lenY;
[~,cutoff_down]=min(Beam(maxBeamXIndex,1:maxBeamYIndex));
 cutoff_down = cutoff_down-1;
cutoff_down(cutoff_down<1)=1;
[~,cutoff_up]=min(Beam(maxBeamXIndex,maxBeamYIndex:end));
cutoff_up = maxBeamYIndex +cutoff_up;
cutoff_up(cutoff_up>lenY)=lenY;

% down - cutoff_down
% [left-cutoff_left,right-cutoff_right,up-cutoff_up,down-cutoff_down]
% left=cutoff_left;
% right=cutoff_right;
% up=cutoff_up;
% down=cutoff_down;
right = abs(ux(cutoff_right)-ux(maxBeamXIndex));
left  = abs(ux(cutoff_left)-ux(maxBeamXIndex));
up   = abs(uy(cutoff_up)-uy(maxBeamYIndex));
down = abs(uy(cutoff_down)-uy(maxBeamYIndex));

kp = max([right left up down]);
%BW = 2/lambda*asin(kp)
BW = 2*asind(kp);
end

