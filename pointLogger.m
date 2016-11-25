classdef pointLogger < handle
    %POINTLOGGER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        points=zeros(0,3);
        curPoint;
        handles=[];
    end
    
    methods
        function setCurPoint(obj,point)
            obj.curPoint=point;
        end
        function addCurPoint(obj)
            obj.points(end+1,:)=obj.curPoint;
            obj.curPoint=[];
        end
        function removeLastPoint(obj)
            if ~isempty(obj.points)
                obj.points(end,:)=[];
            end
            obj.curPoint=[];
        end
        function draw(obj)
            
                delete(obj.handles);
            
            obj.handles=[];
            if ~isempty(obj.points)
                 obj.handles(end+1) = plot3(obj.points(:,1),obj.points(:,2),obj.points(:,3), 'redO', 'MarkerSize', 10); 
                 obj.handles(end+1) = plot3(obj.points(:,1),obj.points(:,2),obj.points(:,3), 'blue.', 'MarkerSize', 30); 
            end
            if ~isempty(obj.curPoint)
                 obj.handles(end+1) = plot3(obj.curPoint(:,1),obj.curPoint(:,2),obj.curPoint(:,3), 'blueO', 'MarkerSize', 10); 
                 obj.handles(end+1) = plot3(obj.curPoint(:,1),obj.curPoint(:,2),obj.curPoint(:,3), 'red.', 'MarkerSize', 30); 
            end
        end
    end
    
end

