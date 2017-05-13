clc
clear
close all 
%% load data
[host, f, nbits] = wavread ('host.wav');   % host signal
host      = uint8(255*(host + 0.5));  % double [-0.5 +0.5] to 'uint8' [0 255]
wm        = imread('watermark.png');  % watermark
[r, c]    = size(wm);                 % watermark size
wm_l      = length(wm(:))*8;          % watermark length
%% watermarking
if length(host) < (length(wm(:))*8)
    disp('your image pixel is not enough')
else
%% prepare host
host_bin  = dec2bin(host, 8);         % binary host [n 8]
%% prepare watermark   
wm_bin    = dec2bin(wm(:), 8);        % binary watermark [n 8]
wm_str    = zeros(wm_l, 1);           % 1-D watermark [(n*8) 1]
for j = 1:8                           % convert [n 8] watermark to [(n*8) 1] watermark
for i = 1:length(wm(:))
ind   = (j-1)*length(wm(:)) + i;
wm_str(ind, 1) = str2double(wm_bin(i, j));
end
end
%% insert watermark into the host
for i     = 1:wm_l                   % insert water mark into the first plane of host               
host_bin(i, 8) = dec2bin(wm_str(i)); % Least Significant Bit (LSB)
end 
%% watermarked host
host_new  = bin2dec(host_bin);       % watermarked host
host_new  = (double(host_new)/255 - 0.5);   % 'uint8' [0 255] to double [-0.5 +0.5]
%% save the watermarked host
wavwrite( host_new, f, nbits, 'host_new5.wav')     % save watermarked host ausio
end

%%wavwrite('host_new.wav', host_new, f)

