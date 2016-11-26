function callbackClickA3DPoint(src, eventData, V,valid,logger)
% CALLBACKCLICK3DPOINT mouse click callback function for CLICKA3DPOINT
%
%   The transformation between the viewing frame and the point cloud frame
%   is calculated using the camera viewing direction and the 'up' vector.
%   Then, the point cloud is transformed into the viewing frame. Finally,
%   the z coordinate in this frame is ignored and the x and y coordinates
%   of all the points are compared with the mouse click location and the 
%   closest point is selected.
%
%   Babak Taati - May 4, 2005
%   revised Oct 31, 2007
%   revised Jun 3, 2008
%   revised May 19, 2009

% point = get(gca, 'CurrentPoint'); % mouse click position
% camPos = get(gca, 'CameraPosition'); % camera position
% camTgt = get(gca, 'CameraTarget'); % where the camera is pointing to
% 
% camDir = camPos - camTgt; % camera direction
% camUpVect = get(gca, 'CameraUpVector'); % camera 'up' vector
% 
% % build an orthonormal frame based on the viewing direction and the 
% % up vector (the "view frame")
% zAxis = camDir/norm(camDir);    
% upAxis = camUpVect/norm(camUpVect); 
% xAxis = cross(upAxis, zAxis);
% yAxis = cross(zAxis, xAxis);
% 
% rot = [xAxis; yAxis; zAxis]; % view rotation 
% 
% % the point cloud represented in the view frame
% rotatedPointCloud = rot * pointCloud(:,valid); 
% % figure(2);
% % clf
% % plot3(rotatedPointCloud(1,:), rotatedPointCloud(2,:), rotatedPointCloud(3,:), 'c.'); 
% % axis equal
% % pause
% % the clicked point represented in the view frame
% rotatedPointFront = rot * point' ;

% find the nearest neighbour to the clicked point 
% pointCloudIndex = dsearchn(rotatedPointCloud(1:2,:)', ... 
%     rotatedPointFront(1:2));
% dists = sum(bsxfun(@(rowA,rowB)(rowA-rowB), rotatedPointCloud(1:2,:)',rotatedPointFront(1:2,1)').^2,2);
% inds=find(dists<1e-4);
% if isempty(inds)
%     disp('no point close enough to click');
%     return;
% end
% candidates=rotatedPointCloud(:,inds);
% candidates(3,:)=candidates(3,:)-max(candidates(3,:));
% d=sum(candidates.^2);
% [~,highest]=min(d);
% 
% pointCloudIndex=inds(highest);
% pointCloudIndex=valid(pointCloudIndex);
% % h = findobj(gca,'Tag','pt'); % try to find the old point
% selectedPoint = pointCloud(:, pointCloudIndex); 
p=eventData.IntersectionPoint;
ind=knnsearch(V(valid,:),p);
ind=valid(ind);
% if isempty(h) % if it's the first click (i.e. no previous point to delete)
%     
%     % highlight the selected point
%     h = plot3(selectedPoint(1,:), selectedPoint(2,:), ...
%         selectedPoint(3,:), 'r.', 'MarkerSize', 20); 
%     set(h,'Tag','pt'); % set its Tag property for later use   
% 
% else % if it is not the first click
% 
%     delete(h); % delete the previously selected point
%     
%     % highlight the newly selected point
%     h = plot3(selectedPoint(1,:), selectedPoint(2,:), ...
%         selectedPoint(3,:), 'r.', 'MarkerSize', 20);  
%     set(h,'Tag','pt');  % set its Tag property for later use
% 
% end
logger.setCurPoint(V(ind,:),ind);
logger.draw();
fprintf('you clicked on point number %d\n', ind);
