function h = clickA3DPoint(V,T)
%CLICKA3DPOINT
%   H = CLICKA3DPOINT(POINTCLOUD) shows a 3D point cloud and lets the user
%   select points by clicking on them. The selected point is highlighted 
%   and its index in the point cloud will is printed on the screen. 
%   POINTCLOUD should be a 3*N matrix, represending N 3D points. 
%   Handle to the figure is returned.
%
%   other functions required:
%       CALLBACKCLICK3DPOINT  mouse click callback function
%       ROWNORM returns norms of each row of a matrix
%       
%   To test this function ... 
%       pointCloud = rand(3,100)*100;
%       h = clickA3DPoint(pointCloud);
% 
%       now rotate or move the point cloud and try it again.
%       (on the figure View menu, turn the Camera Toolbar on, ...)
%
%   To turn off the callback ...
%       set(h, 'WindowButtonDownFcn',''); 
%
%   by Babak Taati
%   http://rcvlab.ece.queensu.ca/~taatib
%   Robotics and Computer Vision Laboratory (RCVLab)
%   Queen's University
%   May 4, 2005 
%   revised Oct 30, 2007
%   revised May 19, 2009

if nargin ~= 2
    error('Requires two input arguments.')
end
V=V';
T=T';
if size(V, 1)~=3
    error('Input point cloud must be a 3*N matrix.');
end

% show the point cloud

hold off
% plot3(V(1,:), V(2,:), V(3,:), 'c.'); 
h=patch('vertices',V','faces',T','facecolor',[0.9 0.9 0.9],'edgecolor','none');
light('Position',[1 0 0],'Style','local','color','cyan')
light('Position',[0 -1  0],'Style','local','color','magenta')
light('Position',[0 0 -1],'Style','local','color','yellow')
h.FaceLighting = 'flat';
h.AmbientStrength = 0.0;
h.DiffuseStrength = 0.8;
h.SpecularStrength = 0.0;
h.SpecularExponent = 25;
h.BackFaceLighting = 'lit';
cameratoolbar('Show'); % show the camera toolbar
hold on; % so we can highlight clicked points without clearing the figure
axis equal
% set the callback, pass pointCloud to the callback function
logger=pointLogger();
h=gcf;
set(h, 'WindowButtonDownFcn', {@callbackClickA3DPoint, V,T,logger}); 
set(h,'KeyPressFcn',{@keyHandler,logger });
end
function keyHandler(h_obj,evt,logger)
if strcmp(evt.Key,'n')
    disp('new point!');
    logger.addCurPoint();
elseif strcmp(evt.Key,'d')
    logger.removeLastPoint();
else 
    return;
end
logger.draw();
end
