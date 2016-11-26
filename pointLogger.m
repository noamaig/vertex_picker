classdef pointLogger < handle
    %POINTLOGGER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        points=zeros(0,3);
        inds=[];
        curInd;
        curPoint;
        handles=[];
    end
    
    methods
        function setCurPoint(obj,point,ind)
            obj.curPoint=point;
            obj.curInd=ind;
        end
        function addCurPoint(obj)
            if isempty(obj.curPoint)
                return;
            end
            obj.points(end+1,:)=obj.curPoint;
            obj.inds(end+1)=obj.curInd;
            obj.curPoint=[];
            obj.curInd=[];
        end
        function removeLastPoint(obj)
            if ~isempty(obj.points)
                obj.points(end,:)=[];
                obj.inds(end)=[];
            end
            obj.curPoint=[];
            obj.curInd=[];
        end
        function draw(obj)
            
                delete(obj.handles);
            
            obj.handles=[];
            if ~isempty(obj.points)
                 obj.handles(end+1) = plot3(obj.points(:,1),obj.points(:,2),obj.points(:,3), 'blackO', 'MarkerSize', 10); 
                 obj.handles(end+1) = plot3(obj.points(:,1),obj.points(:,2),obj.points(:,3), 'blue.', 'MarkerSize', 30); 
                 for i=1:size(obj.points,1)
                 obj.handles(end+1) = text(obj.points(i,1),obj.points(i,2),obj.points(i,3),num2str(i),'fontsize',20);
                 end
            end
            if ~isempty(obj.curPoint)
                 obj.handles(end+1) = plot3(obj.curPoint(:,1),obj.curPoint(:,2),obj.curPoint(:,3), 'blackO', 'MarkerSize', 10); 
                 obj.handles(end+1) = plot3(obj.curPoint(:,1),obj.curPoint(:,2),obj.curPoint(:,3), 'black.', 'MarkerSize', 30); 
                 obj.handles(end+1) = plot3(obj.curPoint(:,1),obj.curPoint(:,2),obj.curPoint(:,3), 'blackX', 'MarkerSize', 20); 
            end
        end
        function save(obj,name)
            assignin('base', 'selected_points', obj.inds);
            disp('the indices of the selected points were exported to the workspace variable ''selected_points''');
            if nargin>1
                SAVE_NAME=[name '_' datestr(now,'yy-mm-dd_HHMM')  ];
                inds=obj.inds;
                save(SAVE_NAME,'inds');
                disp(['and saved to the file named ''' SAVE_NAME '.mat''']);
            end
        end
    end
    
end

