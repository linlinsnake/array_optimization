function [ msl, x, y ] = findMSL( Beam )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

%�����оֲ����ֵ
regionMax = imregionalmax(Beam);
regionMax = (Beam+100).*regionMax;  %BeamԪ��Ϊ��������һ��ƫ�Ʒ���Ƚ�
%��ȡ���ֵ����
[~,maxBeamIndex] = max(regionMax(:));
[maxBeamXIndex,maxBeamYIndex] = ind2sub(size(regionMax), maxBeamIndex);
%���ֵ��Ϊ0
regionMax(maxBeamXIndex, maxBeamYIndex) = 0;
%������԰�
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
