clc;    % Clear the command window.
clear;
directory = '/home/meerahahn/Documents/Projects/Simmons/';
video = 'left_45_3ft';
bag = rosbag(strcat(directory,'Bag_Files/',video,'.bag')); % Load the rosbag.

% %Get color stream
% display('extracting color stream')
% img_dir = strcat(directory,'Color_Streams/',video,'/');
% bSel = select(bag, 'Topic', '/device_0/sensor_1/Color_0/image/data');
% msgs = readMessages(bSel);
% for i = 1 : numel(msgs)
%     img = readImage(msgs{i});
%     name = sprintf('%08d',i);
%     imwrite(img,strcat(img_dir,name,'.png'));
% end
% 
% %Save color stream as avi video
% display('saving color stream as video')
% imageNames = dir(fullfile(img_dir,'*.png'));
% imageNames = {imageNames.name}';
% videoname = strcat(img_dir, '.avi');
% outputVideo = VideoWriter(videoname);
% outputVideo.FrameRate = 30;
% open(outputVideo)
% for ii = 1:length(imageNames)
%    img = imread(fullfile(img_dir,imageNames{ii}));
%    writeVideo(outputVideo,img)
% end
% close(outputVideo)

%Get depth stream
display('extracting depth stream')
img_dir = strcat(directory,'Depth_Streams/',video,'/');
bSel = select(bag, 'Topic', '/device_0/sensor_0/Depth_0/image/data');
msgs = readMessages(bSel);
disparityRange = [0 2000];
for i = 1 : numel(msgs)
    img = readImage(msgs{i});
    figure(1);
    imshow(img,disparityRange);
    colormap(gca,jet) 
    colorbar
    F(i) = getframe(gcf);
end

%Save dpeth stream as avi video
display('saving depth stream as video')
videoname = strcat(directory,'Depth_Streams/',video,'.avi');
outputVideo = VideoWriter(videoname);
outputVideo.FrameRate = 30;
open(outputVideo)
for ii = 1:length(F)
       writeVideo(outputVideo,F(ii))
       display(ii)
end
close(outputVideo)