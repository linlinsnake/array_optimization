function [ msl, x, y ] = findMSL( Beam )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

%找所有局部最大值
regionMax = imregionalmax(Beam);
regionMax = (Beam+100).*regionMax;  %Beam元素为负数，加一个偏移方便比较
%获取最大值坐标
[~,maxBeamIndex] = max(regionMax(:));
[maxBeamXIndex,maxBeamYIndex] = ind2sub(size(regionMax), maxBeamIndex);
%最大值设为0
regionMax(maxBeamXIndex, maxBeamYIndex) = 0;
%找最大旁瓣
[msl, index] = max(regionMax(:));
[x, y] = ind2sub(size(Beam), index);
if msl ~= 0
    msl = msl-100;
end
%msl = msl-100;
end


%% new 1D array
% [peaks,locs] = findpeaks(Beam,'SortStr','descend');
% psll = peaks(2)-peaks(1);
% msl=psll;
