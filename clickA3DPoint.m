function logger = clickA3DPoint(V,T,name)
figure(5);
clf
if nargin<3
    name=[];
end
disp('click on a point on the mesh to select it');
disp('click ''n'' to progress to adding a *n*ew point while saving the prev');
disp('click ''d'' to *d*elete the last inserted point');
disp('click ''s'' to *s*ave and print the selected points to workspace');



% show the point cloud

hold off
% plot3(V(1,:), V(2,:), V(3,:), 'c.'); 
h=patch('vertices',V,'faces',T,'facecolor',[0.9 0.9 0.9],'edgecolor','none');
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
logger=pointLogger(name);
tri=triangulation(T,V);
b=tri.freeBoundary();
if ~isempty(b)
    b=b(:,1);
    
else
    b=1:length(V);
end
hf=gcf;
set(h,'ButtonDownFcn',{@callbackClickA3DPoint,V,b,logger},...
  'PickableParts','visible');
% set(h, 'WindowButtonDownFcn', {@callbackClickA3DPoint, V,T,b,logger}); 
set(hf,'KeyPressFcn',{@keyHandler,logger });
end
function keyHandler(h_obj,evt,logger)
if strcmp(evt.Key,'n')
    disp('new point!');
    logger.addCurPoint();
elseif strcmp(evt.Key,'d')
    logger.removeLastPoint();
elseif strcmp(evt.Key,'s')
    logger.save();
else 
    return;
end
logger.draw();
end
